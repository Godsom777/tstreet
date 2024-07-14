import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../assets/utils/football_api_service.dart';
import '../../components/daily_predictions.dart';

class VipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 63, 3),
        title: Text('VIP Predictions', style: TextStyle(color: Colors.white),),
      ),
      body: MatchesByDateScreen(), // Insert the MatchesByDateScreen widget
    );
  }
}
class MatchesByDateScreen extends StatefulWidget {
  @override
  _MatchesByDateScreenState createState() => _MatchesByDateScreenState();
}

class _MatchesByDateScreenState extends State<MatchesByDateScreen> {
  late MatchAndPredictionManager manager;

  @override
  void initState() {
    super.initState();
    manager = MatchAndPredictionManager();
    manager.initializeMatchAndPredictions(); // Initialize your data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 217, 240, 215),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DatedPredictionsWidget(),
              SizedBox(height: 50),
            ],
          ),
        ),
      )
      
    );
  }
}