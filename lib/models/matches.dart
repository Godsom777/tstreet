class Match {
  final int id;
  final String name;
  final String startingAt;
  final int length;
  final int sportId;
  final int leagueId;
  final int seasonId;
  final int stageId;
  final int stateId;
  final int venueId;
  final String leg;
  final bool placeholder;
  final String lastProcessedAt;
  final int startingAtTimestamp;

  Match({
    required this.id,
    required this.name,
    required this.startingAt,
    required this.length,
    required this.sportId,
    required this.leagueId,
    required this.seasonId,
    required this.stageId,
    required this.stateId,
    required this.venueId,
    required this.leg,
    required this.placeholder,
    required this.lastProcessedAt,
    required this.startingAtTimestamp,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      name: json['name'],
      startingAt: json['starting_at'],
      length: json['length'],
      sportId: json['sport_id'],
      leagueId: json['league_id'],
      seasonId: json['season_id'],
      stageId: json['stage_id'],
      stateId: json['state_id'],
      venueId: json['venue_id'],
      leg: json['leg'],
      placeholder: json['placeholder'],
      lastProcessedAt: json['last_processed_at'],
      startingAtTimestamp: json['starting_at_timestamp'],
    );
  }
}