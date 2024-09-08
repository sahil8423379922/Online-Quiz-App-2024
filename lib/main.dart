import 'package:flutter/material.dart';
import 'package:online_quiz_app/auth/Login.dart';
import 'package:online_quiz_app/auth/Welcome.dart';
import 'package:online_quiz_app/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$appName',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
    );
  }
}
