class MatchInfo {
  final String homeTeam;
  final String awayTeam;
  final int id;
  final String market;
  final String competitionName;
  final String prediction;
  final String competitionCluster;
  final String status;
  final String federation;
  final bool isExpired;
  final String season;
  final String result;
  final String startDate;
  final String lastUpdateAt;
  final Map<String, dynamic> odds;

  MatchInfo({
    required this.homeTeam,
    required this.awayTeam,
    required this.id,
    required this.market,
    required this.competitionName,
    required this.prediction,
    required this.competitionCluster,
    required this.status,
    required this.federation,
    required this.isExpired,
    required this.season,
    required this.result,
    required this.startDate,
    required this.lastUpdateAt,
    required this.odds,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      homeTeam: json['home_team'],
      awayTeam: json['away_team'],
      id: json['id'],
      market: json['market'],
      competitionName: json['competition_name'],
      prediction: json['prediction'],
      competitionCluster: json['competition_cluster'],
      status: json['status'],
      federation: json['federation'],
      isExpired: json['is_expired'],
      season: json['season'],
      result: json['result'],
      startDate: json['start_date'],
      lastUpdateAt: json['last_update_at'],
      odds: json['odds'] != null ? Map<String, dynamic>.from(json['odds']) : {},
    );
  }

  // Example getter for home team name
  String get homeTeamName => homeTeam;

  // Add more getters as needed for away team, league, season, dates, etc.
  String get awayTeamName => awayTeam;
  String get league => competitionName;
  String get matchSeason => season;
  String get matchStartDate => startDate;
  String get matchResult => result;
  // You can also add getters for odds if needed
  double get oddFor1 => odds['1'] ?? 0.0;
  double get oddFor2 => odds['2'] ?? 0.0;
  double get oddFor1X => odds['1X'] ?? 0.0;
  // Add more as needed
}