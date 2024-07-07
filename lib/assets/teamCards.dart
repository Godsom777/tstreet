import 'package:flutter/material.dart';

import 'utils/football_api_service.dart';




class matchCardWithPrediction extends StatelessWidget {
  const matchCardWithPrediction({
    super.key,
    required this.match,
    required this.prediction,
  });

  final Match match;
  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${match.leagueName}',
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.fade,
                    color: Color.fromARGB(122, 0, 0, 0)),
              )
            ],
          ), // League Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 15,
                        child: Image(
                          image: NetworkImage(
                            // Image for home team
                            match.homeTeamLogo!,
                          ),
                        )), //Home Image
    
                    Text(
                      '${match.homeTeam}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              //////////////////
              ///Score for Home team
              ///
              Text(
                '${match.homeGoals}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    '\'${match.elapsed}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                  Text(
                    '${match.long}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                  Text(
                    '${prediction.winnerName ?? "No prediction"}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 124, 8, 1),
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  Container(
                    height: 20,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 1, 81, 4),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFF005200)!),
                    ),
                    child: Center(
                      child: Text(
                        '${prediction.underOver}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              //////////////////
              ///Score for Away Team////
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('${match.awayGoals}',
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 15,
                        child: Image(
                          image: NetworkImage(
                            // Image for home team
                            match.awayTeamLogo!,
                          ),
                        )),
                    Text(
                      '${match.awayTeam}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}




class TeamDetailsScreen extends StatelessWidget {
    late final Match match; // Assuming this is the Match object from football_api_service.dart

  TeamDetailsScreen({required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'teamLogo${match.homeTeamId}', // Use homeTeamId for the tag
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(match.homeTeamLogo!), // Assuming homeTeamLogo is available in Match
              ),
            ),
            SizedBox(height: 20),
            Text('Prediction Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
            // Display prediction details here
            // You would fetch or filter the prediction using match.homeTeamId or match.awayTeamId
            // For demonstration, let's assume we have a function getPredictionDetails that takes a teamId and returns prediction details
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}


