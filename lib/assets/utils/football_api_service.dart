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


Future<List<Match>> dailyPredictions(id) async {
  final response = await http.get(
    Uri.parse('https://api-football-v1.p.rapidapi.com/v3/prediction?fixture=$id'),
    headers: {
      'x-rapidapi-key': '50348be291mshe485f874781559fp179065jsnc4bf8280f2d0',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> matchesJson = jsonDecode(response.body)['response'];
    return matchesJson.map((json) => Match.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Predictions');
  }
}





class Match {
  final int id;
  final String homeTeam;
  final String awayTeam;
  final int homeGoals;
  final int awayGoals;
  final String long;
  final int elapsed;
  final String leagueLogo;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String leagueName;
  // final String win;
  // final String predictionComment;

  Match({required this.id, required this.homeTeam, required this.awayTeam, required this.homeGoals, required this.awayGoals, required this.long, required this.elapsed, 
  required this.leagueLogo, required this.homeTeamLogo, required this.awayTeamLogo, required this.leagueName,
   });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['fixture']['id'],
      homeTeam: json['teams']['home']['name'],
      awayTeam: json['teams']['away']['name'],
      homeGoals: json['goals']['home'],
      awayGoals: json['goals']['away'],
      long: json['fixture']['status']['long'],
      elapsed: json['fixture']['status']['elapsed'],
      leagueLogo: json['league']['name'],
      homeTeamLogo:json['teams']['home']['logo'],
      awayTeamLogo:json['teams']['away']['logo'],
      leagueName: json['league']['logo'],
      // win: json['winner'],
      // predictionComment: json['winner']['name']['comment'],



    );
  }
}