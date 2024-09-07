import 'package:flutter/material.dart';
import 'package:online_quiz_app/auth/login.dart';
import 'package:online_quiz_app/auth/signup.dart';
import 'package:online_quiz_app/constant.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
            height: 420, width: 500, child: Image.asset("assets/welcome.png")),
        const Text(
          appName,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Welcome to $appName where\n you can play oline quiz',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(160, 39, 114, 253),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: const SizedBox(
              height: 48,
              width: 160,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(160, 39, 114, 253), width: 2),
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUp(),
              ));
            },
            child: const SizedBox(
              height: 48,
              width: 160,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Signup",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ))
      ]),
    );
  }
}
