import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_app/auth/Login.dart';
import 'package:online_quiz_app/auth/Welcome.dart';
import 'package:online_quiz_app/constant.dart';
import 'package:online_quiz_app/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
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
      home: SplashScreen(),
    );
  }
}
