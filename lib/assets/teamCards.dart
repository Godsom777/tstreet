import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Provides SVG support for Flutter
import 'package:trenches_street/assets/utils/SizeConfig.dart'; // Utility for responsive layout







// Widget for displaying a card with two teams
class Two_Teams_Card extends StatelessWidget {
  final dynamic prediction; // Holds data for the prediction

  const Two_Teams_Card({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: const Color.fromARGB(255, 244, 244, 244), // Light shadow for depth
            elevation: 10, // Raised button effect
            foregroundColor: const Color(0xFF363636), // Text color
            backgroundColor: Colors.white, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          onPressed: () {}, // Placeholder for button press action
          child: SizedBox(
            height: 120,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                      text: prediction['league'] ?? '', // Display league name
                      children: [
                        TextSpan(
                          text: 'Date: ${prediction['date']} ${prediction['time']}', // Display match date and time
                        )
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(prediction['home_team'] ?? ''), // Display home team name
                    const SizedBox(width: 20),
                    const Text('vs'), // Versus symbol
                    const SizedBox(width: 20),
                    Text(prediction['away_team'] ?? ''), // Display away team name
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for displaying a team card with logo and score
class TeamCard extends StatelessWidget {
  final String teamName; // Name of the team
  final String teamLogo; // Path to the team's logo image
  final int currentScore; // Current score of the team

  const TeamCard({
    super.key,
    required this.teamName,
    required this.teamLogo,
    this.currentScore = 0, // Default score is 0
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(teamLogo), // Display team logo
            radius: 10, // Size of the avatar
          ),
          const SizedBox(width: 10), // Space between logo and text
          SizedBox(
            width: SizeConfig.screenWidth! * 0.2, // Responsive width for team name and score
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(teamName, // Display team name
                    style: const TextStyle(fontSize: 14, color: Color(0xFF262626), fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(' $currentScore', // Display current score
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xDD343434))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying odds in a card
class OddMarker extends StatelessWidget {
  final String odds; // The odds value
  final Color cardColor; // Background color of the card
  final String oddType; // Type of odds

  const OddMarker({
    super.key,
    required this.odds,
    required this.cardColor,
    required this.oddType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor, // Card background color
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Text(
              oddType, // Display the type of odds
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(width: 3),
            Text(
              odds, // Display the odds value
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying a match card with team logos, names, and match info
class MatchCard extends StatelessWidget {
  final String team1Name; // Name of the first team
  final String team2Name; // Name of the second team
  final String matchTime; // Time of the match
  final String matchDate; // Date of the match
  final String predictedWinner; // Predicted winner of the match
  final String team1Logo; // Logo of the first team
  final String team2Logo; // Logo of the second team

  const MatchCard({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.matchTime,
    required this.matchDate,
    required this.predictedWinner,
    required this.team1Logo,
    required this.team2Logo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Card background color
      surfaceTintColor: Colors.white,
      elevation: 20.0, // Shadow depth
      shadowColor: Colors.grey.withOpacity(0.25), // Shadow color
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2, // Allocate space for the first team
                  child: Column(
                    children: [
                      SvgPicture.asset(team1Logo, width: 35), // Display first team's logo
                      Text(team1Name, // Display first team's name
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4, // Allocate space for match time and predicted winner
                  child: Column(children: [
                    const SizedBox(height: 10, width: 10),
                    Text('$matchDate - $matchTime', // Display match date and time
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 10, width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Predicted Winner: ', // Label for predicted winner
                            style: TextStyle(fontSize: 14)),
                        Text(predictedWinner, // Display predicted winner
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ]),
                ),
                Expanded(
                  flex: 2, // Allocate space for the second team
                  child: Column(
                    children: [
                      SvgPicture.asset(team2Logo, width: 35), // Display second team's logo
                      Text(team2Name, // Display second team's name
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

