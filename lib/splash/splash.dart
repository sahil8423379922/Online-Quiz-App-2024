import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_app/auth/Welcome.dart';
import 'package:online_quiz_app/auth/login.dart';
import 'package:online_quiz_app/dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "App Name",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  void gotoNextPage() async {
    // Delay for a while to show the splash screen
    await Future.delayed(const Duration(milliseconds: 1000));

    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Navigate to the appropriate page based on user authentication status
    if (user != null) {
      // User is logged in, navigate to the Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(user: user),
        ),
      );
    } else {
      // User is not logged in, navigate to the Welcome screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      );
    }
  }
}
