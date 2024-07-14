import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/basic/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {


  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference usersCollection;


  final GoogleSignIn googleSignIn = GoogleSignIn();
  
  
  Future<DocumentSnapshot> getUser(String userId) async {
    return await usersCollection.doc(userId).get();
  }

  Future<void> addUser(String userId, String name, String email) async {
    await usersCollection.doc(userId).set({
      'name': name,
      'email': email,
    });
  }

    Future<FirebaseApp> initialize() async {
    FirebaseApp app = await Firebase.initializeApp();
    return app;
  }

  
Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) {
    // handle sign-in cancellation
    return null;
  }
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  UserCredential userCredential = await _auth.signInWithCredential(credential);
  // perform post-sign-in operations before navigating
  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainScreen()));
  return userCredential;
}

Future<UserCredential?> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  try {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // On successful sign-in, navigate to MainScreen or show a success message
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    return credential;
  } on FirebaseAuthException catch (e) {
    // Handle sign-in errors
    String errorMessage = "An error occurred. Please try again.";
    if (e.code == 'user-not-found') {
      errorMessage = "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Wrong password provided for that user.";
    }
    // Show error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign In Failed"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
    return null;
  } catch (e) {
    // Handle any other errors
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("An unexpected error occurred. Please try again."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
    return null;
  }
}
Future<bool> registerUser(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Perform post-registration operations before navigating
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    return true;
  } on FirebaseAuthException catch (e) {
    String errorMessage = "An error occurred. Please try again.";
    // Ensure the error code matches exactly what Firebase documentation states
    if (e.code == 'email-already-in-use') {
      errorMessage = "The email address is already in use by another account.";
    } else if (e.code == 'weak-password') {
      errorMessage = "The password provided is too weak.";
    }
    // Use ScaffoldMessenger to show error message in UI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 5),
      ),
    );

    return false;
  } catch (e) {
    // Handle any other errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("An unexpected error occurred. Please try again."),
        duration: Duration(seconds: 3),
      ),
    );
    return false;
  }
}
}




