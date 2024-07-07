import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

Future<List<Match>> fetchLiveMatches() async {
  final response = await http.get(
    Uri.parse('https://api-football-v1.p.rapidapi.com/v3/fixtures?live=all'),
    headers: {
      'x-rapidapi-key': '50348be291mshe485f874781559fp179065jsnc4bf8280f2d0',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> matchesJson = jsonDecode(response.body)['response'];
    return matchesJson.map((json) => Match.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load live matches');
  }
}




Future<List<Match>> fetchPredictionsForFixture(int matchId) async {
  var response = await http.get(Uri.parse('https://api-football-v1.p.rapidapi.com/v3/predictions?matchId=$matchId'),
    headers: {
      'x-rapidapi-key': '50348be291mshe485f874781559fp179065jsnc4bf8280f2d0',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> matchesJson = json.decode(response.body)['response'];
    List<Match> matches = matchesJson.map((json) => Match.fromJson(json)).toList();
    return matches;
  } else {
    throw Exception('Failed to load predictions');
  }
}




Future<List<Match>> fetchMatchesByDate() async {
  // Format the date as required by your API
  // String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  var response = await http.get(Uri.parse('https://api-football-v1.p.rapidapi.com/v3/fixtures?next=20'),
    headers: {
      'x-rapidapi-key': '50348be291mshe485f874781559fp179065jsnc4bf8280f2d0',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    },);

  if (response.statusCode == 200) {
    List<dynamic> matchesJson = jsonDecode(response.body)['response'];
    List<Match> matches = matchesJson.map((json) => Match.fromJson(json)).toList();
    return matches;
  } else {
    throw Exception('Failed to load matches');
  }
}





class Match {
  final int? id;
  final int? homeTeamId;
  final int? awayTeamId;
  final String? homeTeam;
  final String? awayTeam;
  final int? homeGoals;
  final int? awayGoals;

  final String? long;
  final int? elapsed;
  final String? leagueLogo;
  final String? homeTeamLogo;
  final String? awayTeamLogo;
  final String? leagueName;
  // final String win;
  // final String predictionComment;

  Match({required this.id, required this.homeTeamId, required this.awayTeamId, required this.homeTeam, required this.awayTeam, required this.homeGoals, required this.awayGoals, required this.long, required this.elapsed, 
  required this.leagueLogo, required this.homeTeamLogo, required this.awayTeamLogo, required this.leagueName,
   });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['fixture']['id'],
      homeTeamId: json['teams']['home']['id'],
      awayTeamId: json['teams']['away']['id'],
      homeTeam: json['teams']['home']['name'],
      awayTeam: json['teams']['away']['name'],
      homeGoals: json['goals']['home'],
      awayGoals: json['goals']['away'],
      long: json['fixture']['status']['long'],
      elapsed: json['fixture']['status']['elapsed'],
      leagueName: json['league']['name'],
      homeTeamLogo:json['teams']['home']['logo'],
      awayTeamLogo:json['teams']['away']['logo'],
      leagueLogo: json['league']['logo'],
      // win: json['winner'],
      // predictionComment: json['winner']['name']['comment'],



    );
  }
}


class Prediction {
  final int? winnerId;
  final String? winnerName;
  final String? winnerComment;
  final bool? winOrDraw;
  final String? underOver;
  final String? homeGoals;
  final String? awayGoals;
  final String? advice;
  final Map<String, String>? percent;

  Prediction({
    required this.winnerId,
    required this.winnerName,
    required this.winnerComment,
    required this.winOrDraw,
    required this.underOver,
    required this.homeGoals,
    required this.awayGoals,
    required this.advice,
    required this.percent,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      winnerId: json['predictions']['winner']['id'],
      winnerName: json['predictions']['winner']['name'],
      winnerComment: json['predictions']['winner']['comment'],
      winOrDraw: json['predictions']['win_or_draw'],
      underOver: json['predictions']['under_over'],
      homeGoals: json['predictions']['goals']['home'],
      awayGoals: json['predictions']['goals']['away'],
      advice: json['predictions']['advice'],
      percent: {
        'home': json['predictions']['percent']['home'],
        'draw': json['predictions']['percent']['draw'],
        'away': json['predictions']['percent']['away'],
      },
    );
  }
}

class MatchPrediction {
  final Match match;
  final Prediction prediction;

  MatchPrediction({required this.match, required this.prediction});
}


