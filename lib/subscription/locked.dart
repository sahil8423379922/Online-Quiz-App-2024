import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/subscription/plan.dart';

class Locked extends StatefulWidget {
  final user;
  const Locked({super.key, this.user});

  @override
  State<Locked> createState() => _LockedState();
}

class _LockedState extends State<Locked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: SizedBox(
                  height: 220,
                  width: 220,
                  child: Image.asset(
                      'assets/lock.png')), // Replace with your actual image path
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Loked! Subscribe to Access",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Plan(
                          user: widget.user,
                        )));
              },
              child: Card(
                  color: Color.fromARGB(255, 255, 77, 64),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                    child: Text(
                      "Subsribe Now",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )))
        ],
      ),
    );
  }
}
