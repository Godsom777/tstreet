import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:trenches_street/assets/teamCards.dart';
import 'dart:convert';
import '../assets/utils/SizeConfig.dart';
import '../assets/utils/football_api_service.dart'; // Assuming this is where Prediction is defined
import 'package:awesome_dialog/awesome_dialog.dart';

Future<List<Prediction>> fetchPredictionsForFixture(int fixtureId) async {
  final response = await http.get(
    Uri.parse(
        'https://api-football-v1.p.rapidapi.com/v3/predictions?fixture=$fixtureId'),
    headers: {
      'x-rapidapi-key': '50348be291mshe485f874781559fp179065jsnc4bf8280f2d0',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> predictionsJson = jsonDecode(response.body)['response'];
    return predictionsJson.map((json) => Prediction.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Predictions for fixture $fixtureId');
  }
}

class MatchAndPredictionManager {
Map<DateTime, List<MatchPrediction>> groupedMatchesWithPredictions = {};
  late Map<String, dynamic> matchAndPredictions;

  MatchAndPredictionManager() {
    initializeMatchAndPredictions();
  }



  Future<void> initializeMatchAndPredictions() async {
        List<Match> liveMatches = await fetchLiveMatches(); 
            groupedMatchesWithPredictions = {}; // Example direct initialization
// Assuming fetchLiveMatches is defined and fetches live matches

    matchAndPredictions = await fetchMatchesAndPredictions();
        List<MatchPrediction> matchesWithPredictions = [];

        for (var match in liveMatches) {
      try {
        List<Prediction> predictions = await fetchPredictionsForFixture(match.id!);
        if (predictions.isNotEmpty) {
          matchesWithPredictions.add(MatchPrediction(match: match, prediction: predictions.first));
        }
      } catch (e) {
        print("Error fetching predictions for match ${match.id}: $e");
      }
    }

    // Sort matches by date
    matchesWithPredictions.sort((a, b) => a.match.dateTime!.compareTo(b.match.dateTime!));

    // Group matches by date
    groupedMatchesWithPredictions = {};
    for (var matchPrediction in matchesWithPredictions) {
      DateTime date = DateFormat('yyyy-MM-dd').parse(matchPrediction.match.dateTime!); // Assuming dateTime is a String in Match
      groupedMatchesWithPredictions.putIfAbsent(date, () => []).add(matchPrediction);
    }


  }

  Future<Map<String, dynamic>> fetchMatchesAndPredictions() async {
    // Fetch live matches
    List<Match> liveMatches =
        await fetchLiveMatches(); // Assuming fetchLiveMatches is defined elsewhere in football_api_service.dart
    // Check if there are live matches available
    if (liveMatches.isNotEmpty) {
      Map<String, dynamic> matchesWithPredictions = {};
      for (var match in liveMatches) {
        try {
          List<Prediction> predictions = await fetchPredictionsForFixture(
              match.id!); // Fetch predictions for each match
          if (predictions.isNotEmpty) {
            matchesWithPredictions[match.id.toString()] = {
              'match': match,
              'predictions': predictions,
            };
          }
        } catch (e) {
          // Log the error or handle it as needed
          print("Error fetching predictions for fixture ${match.id}: $e");
          // Optionally, you can still add the match without predictions
          matchesWithPredictions[match.id.toString()] = {
            'match': match,
            'predictions': [],
          };
        }
      }
      return matchesWithPredictions;
    } else {
      // Return empty if no live matches are found
      return {};
    }
  }

  Widget buildMatchesWidget() {
    return ListView.builder(
      itemCount: groupedMatchesWithPredictions.keys.length,
      itemBuilder: (context, index) {
        DateTime date = groupedMatchesWithPredictions.keys.elementAt(index);
        List<MatchPrediction> matchesForDate = groupedMatchesWithPredictions[date]!;
        
        return Card(
          child: Column(
            children: [
              Text(DateFormat('yyyy-MM-dd').format(date)), // Display the date
              ...matchesForDate.map((matchPrediction) => ListTile(
                    title: Text("${matchPrediction.match.homeTeam} vs ${matchPrediction.match.awayTeam}"),
                    subtitle: Text("Prediction: ${matchPrediction.prediction}"),
                  )),
            ],
          ),
        );
      },
    );
    }
    
    
    
    
    
    
    }
    
    /////////////Live Matches with predictions////
    
    class LivePredictionsWidget extends StatefulWidget {
      @override
      _LivePredictionsWidgetState createState() => _LivePredictionsWidgetState();
    }
    
    class _LivePredictionsWidgetState extends State<LivePredictionsWidget> {
      late Future<Map<String, dynamic>> _matchAndPredictions;
      Timer? _timer;
      final Duration _refreshInterval = Duration(minutes: 5);
    
    
    
    
      Future<void> _fetchData() async {
        setState(() {
          _matchAndPredictions =
              MatchAndPredictionManager().fetchMatchesAndPredictions();
        });
      }
    
      @override
      void initState() {
        super.initState();
        _matchAndPredictions =
            MatchAndPredictionManager().fetchMatchesAndPredictions();
      }
    
      @override
      Widget build(BuildContext context) {
        return SizedBox(
          height: SizeConfig.screenHeight! / 6,
          width: SizeConfig.screenWidth,
          child: FutureBuilder<Map<String, dynamic>>(
            future: _matchAndPredictions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                      final List<Match> match = await fetchLiveMatches();
    
                        await fetchPredictionsForFixture(match as int);
                      
                    },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String key = snapshot.data!.keys.elementAt(index);
                      Match match = snapshot.data![key]['match'] as Match;
                      Prediction prediction = snapshot.data![key]['predictions'][0]
                          as Prediction; // Assuming we take the first prediction
                      return matchCardWithPrediction(
                          match: match, prediction: prediction);
                  
                      // ListTile(
                      //   title: Text('${match.homeTeam} vs ${match.awayTeam}'),
                      //   subtitle: Text('Predicted Winner: ${prediction.winnerName ?? "No prediction"}'),
                      //   leading: CircleAvatar(
                      //     backgroundImage: NetworkImage(match.leagueLogo!),
                      //   ),
                      // );
                    },
                  ),
                );
              } else {
                return Text("No data");
              }
            },
          ),
        );
      }
    
      @override
      void dispose() {
        _timer?.cancel();
        super.dispose();
      }
    }
    
    // In lib/components/dated_predictions_widget.dart
    
    class DatedPredictionsWidget extends StatefulWidget {
      @override
      _DatedPredictionsWidgetState createState() => _DatedPredictionsWidgetState();
    }
    
    class _DatedPredictionsWidgetState extends State<DatedPredictionsWidget> {
        DateTime selectedDate = DateTime.now();
    
      late Future<Map<String, dynamic>> _matchesAndPredictions;
    
      @override
      void initState() {
        super.initState();
        _matchesAndPredictions = fetchMatchesAndPredictions();
      }
    
      Future<Map<String, dynamic>> fetchMatchesAndPredictions() async {
        List<Match> matches = await fetchMatchesByDate(); // Fetch matches by date
        Map<String, dynamic> matchesWithPredictions = {};
    
        for (Match match in matches) {
          try {
            // Fetch predictions for each match using its fixture ID
            List<Prediction> predictions =
                await fetchPredictionsForFixture(match.id!);
            matchesWithPredictions[match.id.toString()] = {
              'match': match,
              'predictions': predictions,
            };
          } catch (e) {
            print("Error fetching predictions for match ${match.id}: $e");
            // Optionally, handle the error by adding the match without predictions
            matchesWithPredictions[match.id.toString()] = {
              'match': match,
              'predictions': [],
            };
          }
        }
    
        return matchesWithPredictions;
      }
    
      @override
      Widget build(BuildContext context) {
        // Use FutureBuilder to build the UI based on _matchesAndPredictions future
        return SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: FutureBuilder<Map<String, dynamic>>(
        future: _matchesAndPredictions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(children: [Text('Loading Predictions'),CircularProgressIndicator()]);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic> data = snapshot.data!;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String key = data.keys.elementAt(index);
                Match match = snapshot.data![key]['match'] as Match;
                if (snapshot.data![key]['predictions'] is List<Prediction> &&
                    (snapshot.data![key]['predictions'] as List<Prediction>)
                        .isNotEmpty) {
                  Prediction predictions = (snapshot.data![key]['predictions']
                      as List<Prediction>)[0];

                  // Wrap the widget in a GestureDetector to handle taps
                  return 
                  GestureDetector(
                      onTap: () {
                        AwesomeDialog(
                      context: context,
                      barrierColor: Colors.green,
                      dialogType: DialogType.info,
                      headerAnimationLoop: false,
                      animType: AnimType.scale,
                      title: 'Details',
                      buttonsTextStyle: const TextStyle(color: Colors.black),
                      showCloseIcon: false,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                      },
                      child: Hero(
                        tag: 'teamLogo${match.homeTeamId}',
                        child: matchCardWithPrediction(match: match, prediction: predictions,)
                      ));
                } else {
                  return Text('No predictions available for this match');
                }
              },
            );
          }
        },
      ),
    );
  }
}


