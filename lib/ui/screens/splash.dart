import 'package:booking/ui/home.dart';
import 'package:booking/ui/screens/auth/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const String routeName = "splash";
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User?>(
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              // User is logged in, navigate to Home
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              });
            } else {
              // User is not logged in, navigate to Login
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              });
            }
            return Container(); // Return an empty container while processing
          },
        ),
      ),
    );
  }
}
