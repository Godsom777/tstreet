import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'),
        backgroundColor: Colors.green, // Set the app bar background color to green
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchWhatsApp();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.message), // Add a message icon
              SizedBox(width: 8), // Add some spacing
              Text('Contact Us on WhatsApp'),
            ],
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.green, // Set the button text color to white
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded corners to the button
            ),
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    String url = 'https://wa.me/+2348082896647'; // Replace with your WhatsApp number
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
}