import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/dashboard/dynamicrowscreen.dart';

class LiveQuiz extends StatefulWidget {
  final subscription;
  final user;
  const LiveQuiz({super.key, this.subscription, this.user});

  @override
  State<LiveQuiz> createState() => _LiveQuizState();
}

class _LiveQuizState extends State<LiveQuiz> {
  @override
  Widget build(BuildContext context) {
    return DynamicRowScreen(
        subscription: widget.subscription, user: widget.user);
  }
}
