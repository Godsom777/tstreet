import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trenches_street/assets/utils/SizeConfig.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Container(
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
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
                      color: Colors.green),
                )
              ],
            ), // League Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
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
                            overflow: TextOverflow.clip),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                //////////////////
                ///Score for Home team
                ///
                Text(
                  '${match.homeGoals ?? ' '}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          '${match.elapsed ?? prediction.advice}',
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w400),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    match.long != "Not Started"
                        ? Text(
                            '${match.long}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            maxLines: 1,
                          )
                        : SizedBox.shrink(),
                    Text(
                      '${prediction.winnerName ?? "No prediction"}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(4, 124, 8, 1),
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 3, 56, 5),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xFF005200)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 18, 71, 1).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${prediction.winnerComment}',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 255, 255, 255),
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
                  child: Text('${match.awayGoals ?? ' '}',
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                ),
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          maxRadius: 15,
                          child: Image(
                            image: NetworkImage(
                              // Image for away team
                              match.awayTeamLogo!,
                            ),
                          )),
                      Text(
                        '${match.awayTeam}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.clip,
                            textBaseline: TextBaseline.alphabetic),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TeamDetailsScreen extends StatelessWidget {
  late final Match match;
  late final Prediction
      prediction; // Assuming this is the Match object from football_api_service.dart

  TeamDetailsScreen({required this.match, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Details',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 3, 49, 4),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 3, 49, 4),
                  image: DecorationImage(
                      image: AssetImage(
                        'images/bg.png',
                      ),
                      opacity: 0.25,
                      fit: BoxFit.cover)),
              height: SizeConfig.screenHeight! / 3.5,
              width: SizeConfig.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag:
                        'teamLogo${match.homeTeamId}', // Use homeTeamId for the tag
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(match
                                    .homeTeamLogo!), // Assuming homeTeamLogo is available in Match
                              ),
                              Text(
                                '${match.homeTeam}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            'VS',
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(match
                                    .awayTeamLogo!), // Assuming homeTeamLogo is available in Match
                              ),
                              Text(
                                '${match.awayTeam}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '${prediction.advice}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ))

                  // Display prediction details here
                  // You would fetch or filter the prediction using match.homeTeamId or match.awayTeamId
                  // For demonstration, let's assume we have a function getPredictionDetails that takes a teamId and returns prediction details
                  // Add more details as needed
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Column(
                      children: [
                        Text('Last 6 Games',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         RichText(
  text: TextSpan(
      children: prediction.homeForm?.substring(
      prediction.homeForm!.length > 6 ? prediction.homeForm!.length - 6 : 0
    ).split('').map((char) {
      return TextSpan(
        text: char,
        style: TextStyle(
          color: char == 'W' ? Colors.green : (char == 'L' ? Colors.red : Colors.black),
fontSize: 20, fontWeight: FontWeight.bold        ),
      );
    }).toList(),
  ),
),       RichText(
  text: TextSpan(
     children: prediction.awayForm?.substring(
      prediction.awayForm!.length > 6 ? prediction.awayForm!.length - 6 : 0
    ).split('').map((char) {
      return TextSpan(
        text: char,
        style: TextStyle(
          color: char == 'W' ? Colors.green : (char == 'L' ? Colors.red : Colors.black),
fontSize: 20, fontWeight: FontWeight.bold        ),
      );
    }).toList(),
  ),
),


                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Text('${prediction.formPercentage}',  style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
