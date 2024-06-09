import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trenches_street/assets/teamCards.dart';
import 'package:trenches_street/assets/utils/football_api_service.dart';

class LiveMatches extends StatefulWidget {
  const LiveMatches({super.key});
  @override
  State<LiveMatches> createState() => _LiveMatchesState();
}

class _LiveMatchesState extends State<LiveMatches> {
  final FootballApiService _apiService = FootballApiService();

  @override
  Widget build(BuildContext context) {
    return games_card();
  }

  Container games_card() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0x4F252525), width: 0.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0x5D39553E).withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 15, right: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: const TextSpan(
                  text: 'Premier',
                  style: TextStyle(
                    color: Color(0x90373737),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' League',
                      style: TextStyle(
                        color: Color(0xA6F44336),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Text('\'15',
                      style: TextStyle(
                        color: Color(0x90373737),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )),
                      Icon( Icons.circle, color: Colors.green, size: 10,)
          
                ],
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeamCard(
                  teamName: 'Chelsea',
                  teamLogo: 'images/chelsea.png',
                ),
                SizedBox(
                  height: 10,
                ),
                TeamCard(
                  teamName: 'Arsenal',
                  teamLogo: 'images/arsenal.png',
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      OddMarker(
                        oddType: 'Home',
                        odds: '1.5',
                        cardColor: Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      OddMarker(
                        oddType: 'Draw',
                        odds: '13.5',
                        cardColor: Color.fromARGB(255, 212, 47, 47),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      OddMarker(
                        oddType: 'Away',
                        odds: '3.5',
                        cardColor: Colors.green,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //   FutureBuilder<List<dynamic>>(
  //     future: _apiService.getDailyPredictions(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Column(
  //           children: snapshot.data!.map((prediction) => Two_Teams_Card(prediction: prediction)).toList(),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text("${snapshot.error}");
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }
}
