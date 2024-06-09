import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballApiService {
  final String _baseUrl = 'https://today-football-prediction.p.rapidapi.com';
  final Map<String, String> _headers = {
    'X-RapidAPI-Key': 'f06c1efc31msh1bbfec983428082p18e62ejsnddb14367dde6',
    'X-RapidAPI-Host': 'today-football-prediction.p.rapidapi.com'
  };


///////EPL////////////////////////
  Future<List<dynamic>> getDailyPredictions() async {
    final response = await http.get(Uri.parse('$_baseUrl/predictions/list?market=1X2&league=1&page=1'),
        headers: _headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body['matches'];
    } else {
      throw Exception('Failed to load daily predictions');
    }
  }

  Future<List<dynamic>> getPredictionsByLeague(String league) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/predictions/list?market=1X2&league=3&page=1'),
        headers: _headers);
   if (response.statusCode == 200) {
  var body = jsonDecode(response.body);
  if (body['matches'] != null) {
    return body['matches'];
  } else {
    throw Exception('No matches found for market: OU25 and league: $league');
  }
} else {
      throw Exception('Failed to load predictions for league: $league');
    }
  }


Future<List<dynamic>> getTodaysMatches() async {
  final response = await http.get(
      Uri.parse('$_baseUrl/matches/today'),
      headers: _headers);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return body['matches'];
  } else {
    throw Exception('Failed to load today\'s matches');
  }
}

}