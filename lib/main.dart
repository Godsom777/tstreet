import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trenches_street/assets/utils/SizeConfig.dart';
import 'package:trenches_street/auth/SignIn/SignUpScreens.dart';
import 'package:trenches_street/auth/auth_service.dart';
import 'package:trenches_street/screens/basic/home_screen.dart'; // Importing AuthService

Future<void> _initializeApp() async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();

  // hide system app bar

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Initialize your AuthService
        future: AuthService().initialize(),
        builder: (context, snapshot) {
          // Show loading screen while waiting for initialization
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            // Once initialized, decide which screen to show
            if (snapshot.hasError) {
              return const Text('Error initializing Firebase');
            } else {
              return const HomeScreen();
            }
          }
        },
      ),
    );
  }
}
