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
  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  return userCredential;
}

Future<UserCredential?> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  try {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // perform post-sign-in operations before navigating
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    return credential;
  } on FirebaseAuthException catch (e) {
    // show error messages to the user
    return null;
  }
}

Future<bool> registerUser(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // perform post-registration operations before navigating
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    return true;
  } catch (e) {
    // handle exceptions
    return false;
  }
}
}




