import 'package:flutter/material.dart';
import 'package:trenches_street/auth/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Signup'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                setState(() => _email = value);
              },
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              onChanged: (value) {
                setState(() => _password = value);
              },
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _authService.signInWithEmailAndPassword(_email, _password, context);
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _authService.registerUser(_email, _password, context);
                }
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.google, color: Colors.white),
              label: Text('Sign Up with Google'),
              onPressed: () async {
                await _authService.signInWithGoogle(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}