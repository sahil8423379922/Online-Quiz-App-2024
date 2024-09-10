import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/dashboard/dynamicrowscreen.dart';

class LiveQuiz extends StatefulWidget {
  const LiveQuiz({super.key});

  @override
  State<LiveQuiz> createState() => _LiveQuizState();
}

class _LiveQuizState extends State<LiveQuiz> {
  @override
  Widget build(BuildContext context) {
    return DynamicRowScreen();
  }
}
