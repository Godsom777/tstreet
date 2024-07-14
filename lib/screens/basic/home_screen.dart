import "dart:convert";

import "package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:getwidget/getwidget.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:trenches_street/assets/teamCards.dart";
import "package:trenches_street/assets/utils/SizeConfig.dart";
import 'package:trenches_street/assets/teamCards.dart';
import "package:trenches_street/screens/basic/settings.dart";
import "package:trenches_street/screens/basic/vipScreen.dart";
import "../../assets/leagues.dart";
import 'package:http/http.dart' as http;

import "../../assets/utils/football_api_service.dart" as api;
import "../../components/daily_predictions.dart";
import "../../models/liveMatchWigets.dart";

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0; // To keep track of the active tab index
  final List<Widget> _pages = [
    HomeScreen(), // Assuming HomeScreen is a widget
    VipScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_bottomNavIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Colors.green,
        splashRadius: 20,
        splashSpeedInMilliseconds: 899,
        iconSize: 32,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        icons: [
          // Icon for Home
          FontAwesomeIcons.soccerBall, // Icon for Football
          FontAwesomeIcons.crown, // Icon for VIP
          FontAwesomeIcons.whatsapp, // Icon for contact us
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        // Customize the appearance as needed
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Future<List<Match>> _matches;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), // Adjust duration to control speed
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            double maxScrollExtent = _scrollController.position.maxScrollExtent;
            double position = maxScrollExtent * _animation.value;

            // Automatically scroll to the position calculated by the animation
            _scrollController.jumpTo(position);

            // Reverse the animation if it completes to create a back and forth effect
            if (_animation.value == 1.0) {
              _animationController.reverse();
            } else if (_animation.value == 0.0) {
              _animationController.forward();
            }
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  void updateHighlightedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                      width: 100,
                    ),
                    const Text(
                      'TRENCHES STREET',
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

              ///Carousel//////////////

              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage('images/ts.PNG'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage('images/ts2.PNG'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage('images/ts3.PNG'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 2.0,
                    initialPage: 3,
                  ),
                ),
              ),

              // Leagues section
              SingleChildScrollView(
                controller: _scrollController,
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

              LiquidPullToRefresh(
                springAnimationDurationInMilliseconds: 400,
                color: Color.fromARGB(255, 5, 110, 27),
                height: 70,
                //////////////////////////
                onRefresh: () async {
                  final List<api.Match> match = await api.fetchLiveMatches();

                  await fetchPredictionsForFixture(match as int);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(23)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Live Matches section
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 8),
                            child: Text(
                              'Live Matches Predictions', // Text for "Live Matches"
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
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 15.0, bottom: 8, top: 20),
                                child: Text(
                                    'Upcoming Matches Predictions', // Text for "Upcoming Matches"
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xCB202020)))),
                          ),
                          // New code block

                          // Daily Predictions widget
                          DatedPredictionsWidget()
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Bottom Date Bar widget

// class _BottomDateBarState extends State<BottomDateBar> {
//   DateTime selectedDate = DateTime.now();
//   void updateSelectedDate(DateTime newDate) {
//     setState(() {
//       selectedDate = newDate;
//     });
//     // Assuming DatedPredictionWidget is a child of BottomBarState, you would pass selectedDate to it
//   }

class BottomDateBar extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  DateTime selectedDate; // Add this line

  BottomDateBar({
    Key? key,
    required this.onDateSelected,
    required this.selectedDate, // Add this line
  }) : super(key: key);

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
                selectedDate = date;
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
