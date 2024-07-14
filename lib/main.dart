import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trenches_street/assets/utils/SizeConfig.dart';
import 'package:trenches_street/auth/SignIn/SignUpScreens.dart';
import 'package:trenches_street/auth/auth_service.dart';
import 'package:trenches_street/screens/basic/home_screen.dart';


Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize AuthService here and ensure it's ready before proceeding
  await AuthService().initialize();
}

void main() async {
  await _initializeApp();
  // hide system app bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Since AuthService is initialized before the app runs, we can directly navigate to the desired screen
        // home: LoginSignupScreen(),
        home: LoginSignupScreen(),
      ),
    );
  }
}
