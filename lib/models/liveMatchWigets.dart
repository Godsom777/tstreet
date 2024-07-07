
// import 'package:flutter/material.dart';

// import '../assets/utils/SizeConfig.dart';
// import '../assets/utils/football_api_service.dart';
// import '../components/daily_predictions.dart';

// class LiveMatchesWidget extends StatefulWidget {
//   const LiveMatchesWidget({
//     super.key,
//   });

//   @override
//   State<LiveMatchesWidget> createState() => _LiveMatchesWidgetState();
// }

// class _LiveMatchesWidgetState extends State<LiveMatchesWidget> {

//   late Future<Map<String, dynamic>> _matchAndPredictions;

//   @override
//   void initState() {
//     super.initState();
//     _matchAndPredictions = MatchAndPredictionManager().fetchMatchesAndPredictions();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       width: SizeConfig.screenWidth,
//       child: FutureBuilder<List<Match>>(
//         future: fetchLiveMatches(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Center(
//               child: ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 // scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                      String key = snapshot.data!.keys.elementAt(index);
//                 Match match = snapshot.data![key]['$match.id'] as Match;
//                 Prediction prediction = snapshot.data![key]['predictions'][0] as Prediction; // Assuming we take the first prediction

//                   return Container(
//                     width: SizeConfig.screenWidth,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           BorderRadius.circular(15),
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     margin: const EdgeInsets.all(8),
//                     child: Center(
//                       child: Container(
//                         width: SizeConfig.screenWidth,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .spaceAround,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '${match.leagueName}',
//                                     style: const TextStyle(
//                                         fontWeight:
//                                             FontWeight
//                                                 .normal,
//                                         overflow:
//                                             TextOverflow
//                                                 .fade,
//                                         color:
//                                             Color.fromARGB(
//                                                 122,
//                                                 0,
//                                                 0,
//                                                 0)),
//                                   )
//                                 ],
//                               ), // League Name
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment
//                                         .center,
//                                 children: [
//                                   SizedBox(
//                                     width: 100,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment
//                                               .center,
//                                       children: [
//                                         CircleAvatar(
//                                             backgroundColor:
//                                                 Colors
//                                                     .transparent,
//                                             maxRadius: 15,
//                                             child: Image(
//                                               image:
//                                                   NetworkImage(
//                                                 // Image for home team
//                                                 match
//                                                     .homeTeamLogo,
//                                               ),
//                                             )), //Home Image
    
//                                         Text(
//                                           '${match.homeTeam}',
//                                           style: const TextStyle(
//                                               fontWeight:
//                                                   FontWeight
//                                                       .bold,
//                                               overflow:
//                                                   TextOverflow
//                                                       .fade),
//                                           maxLines: 1,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   //////////////////
//                                   ///Score for Home team
//                                   ///
//                                   Text(
//                                     '${match.homeGoals}',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         '\'${match.elapsed}',
//                                         style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w400),
//                                         maxLines: 1,
//                                       ),
//                                       Text(
//                                         '${match.long}',
//                                         style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w400),
//                                         maxLines: 1,
//                                       ),
//                                          Text(
//                                         '${prediction.winnerComment}',
//                                         style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w400),
//                                         maxLines: 1,
//                                       ),

//                                     ],
//                                   ),
//                                   //////////////////
//                                   ///Score for Away Team////
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets
//                                             .all(18.0),
//                                     child: Text(
//                                         '${match.awayGoals}',
//                                         style:
//                                             const TextStyle(
//                                           fontSize: 20,
//                                         )),
//                                   ),
//                                   SizedBox(
//                                     width: 100,
//                                     child: Column(
//                                       children: [
//                                         CircleAvatar(
//                                             backgroundColor:
//                                                 Colors
//                                                     .transparent,
//                                             maxRadius: 15,
//                                             child: Image(
//                                               image:
//                                                   NetworkImage(
//                                                 // Image for home team
//                                                 match
//                                                     .awayTeamLogo,
//                                               ),
//                                             )),
//                                         Text(
//                                           '${match.awayTeam}',
//                                           style: const TextStyle(
//                                               fontWeight:
//                                                   FontWeight
//                                                       .bold,
//                                               overflow:
//                                                   TextOverflow
//                                                       .fade),
//                                           maxLines: 1,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//           return const SizedBox(
//               height: 50,
//               width: 50,
//               child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }