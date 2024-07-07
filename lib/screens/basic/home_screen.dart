import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:getwidget/getwidget.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import "package:trenches_street/assets/teamCards.dart";
import "package:trenches_street/assets/utils/SizeConfig.dart";
import 'package:trenches_street/assets/teamCards.dart';
import "../../assets/leagues.dart";
import 'package:http/http.dart' as http;

import "../../assets/utils/football_api_service.dart";
import "../../components/daily_predictions.dart";
import "../../models/liveMatchWigets.dart";

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  DateTime selectedDate = DateTime.now();

  void updateHighlightedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 50,
                    ),
                    const Text(
                      'TrenchesStreet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF032701),
                      ),
                    ),
                  ],
                ),
                // const GFAvatar(
                //     backgroundImage:
                //         NetworkImage('https://via.placeholder.com/50'),
                //     shape: GFAvatarShape.circle)
              ],
            ),
          ),
        ),
      ),

      // Body section
      body: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title section
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Football ', // Text for "Football"
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF151515),
                        ),
                      ),
                      TextSpan(
                        text: 'Leagues', // Text for "Leagues"
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7DC61E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Leagues section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/epl.svg'), // CustomCircleAvatar for EPL
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/uefa-champions-league.svg'), // CustomCircleAvatar for UEFA Champions League
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/liga-bbva.svg'), // CustomCircleAvatar for Liga BBVA
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/serie-a.svg'), // CustomCircleAvatar for Serie A
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/bundesliga.svg'), // CustomCircleAvatar for Bundesliga
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/super-liga.svg'), // CustomCircleAvatar for Super Liga
                    CustomCircleAvatar(
                        onTap: () {},
                        imagePath:
                            'images/leagues/liga-portugal.svg'), // CustomCircleAvatar for Liga Portugal
                  ], // Wrap CustomCircleAvatar in a list
                ),
              ),

              // Container section
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.circular(23)),
                child:  SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Live Matches section
                          // Live Matches section
                      const Padding(
                          padding: EdgeInsets.only(left: 15.0, bottom: 8),
                          child: Text(
                            'Live Matches', // Text for "Live Matches"
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xCB202020),
                            ),
                          ),
                        ),

                        // Live Matches widget
                        LivePredictionsWidget(),

                        // Upcoming Matches section
                       const Padding(
                          padding:
                              EdgeInsets.only(left: 15.0, bottom: 8, top: 20),
                          child: Text(
                              'Upcoming Matches/Predictions', // Text for "Upcoming Matches"
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xCB202020))),
                        ),

                        // Daily Predictions widget
                        DatedPredictionsWidget()
                                               

                      
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomDateBar(), // Bottom navigation bar
    );
  }
}


// Bottom Date Bar widget
class BottomDateBar extends StatefulWidget {
  const BottomDateBar({super.key});

  @override
  _BottomDateBarState createState() => _BottomDateBarState();
}

class _BottomDateBarState extends State<BottomDateBar> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 14,
          itemBuilder: (context, index) {
            final date = DateTime.now().add(Duration(days: index));
            final isSelected = DateFormat('yyyyMMdd').format(date) ==
                DateFormat('yyyyMMdd').format(selectedDate);
            return InkWell(
              onTap: () {
                setState(() {
                  selectedDate = date;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      DateFormat('d').format(date), // Day of the date
                      style: TextStyle(
                          fontSize: isSelected ? 18 : 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF7DC61E)
                              : const Color(0x95607D8B)),
                    ),
                    Text(
                      DateFormat('EEE').format(date), // Weekday of the date
                      style: TextStyle(
                          fontSize: isSelected ? 18 : 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF7DC61E)
                              : const Color(0x95607D8B)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}