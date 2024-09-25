import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/quiz/quiz.dart';
import 'package:online_quiz_app/quiz/result.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({super.key});

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  //basic questions
  final _questions = const [
    {
      'questionText':
          'Which TWO of the following are freedoms offered to citizens and permanent residents of the UK?',
      'answers': [
        {'text': 'Free heating for all', 'score': -2},
        {
          'text': 'A right to take part in the election of a government',
          'score': -2
        },
        {'text': 'Half day off work on Friday', 'score': 10},
        {'text': 'Freedom of speech', 'score': -2},
      ],
    },
    {
      'questionText': 'What is a fundamental principle of British life?',
      'answers': [
        {'text': 'Democracy', 'score': -2},
        {'text': 'A relaxed work ethic', 'score': -2},
        {'text': 'Religious faith', 'score': -2},
        {'text': 'Extremism ', 'score': 10},
      ],
    },
    {
      'questionText':
          'What were the names of the TWO main groups in parliament in the early 18th century?',
      'answers': [
        {'text': 'Labour', 'score': -2},
        {'text': 'Tories', 'score': 10},
        {'text': 'Nationalists', 'score': -2},
        {'text': 'Whigs', 'score': -2},
      ],
    },
    {
      'questionText':
          'Is the statement below TRUE or FALSE?When Queen Anne died, a German, George of Hanover, became the next King of England.',
      'answers': [
        {'text': 'TRUE', 'score': 10},
        {'text': 'FALSE', 'score': -2},
      ],
    },
    {
      'questionText':
          'Which TWO wars was England involved in during the Middle Ages?',
      'answers': [
        {'text': 'Peninsular', 'score': 10},
        {'text': 'Hundred Years War', 'score': -2},
        {'text': 'Crimean', 'score': -2},
        {'text': 'Crusades', 'score': -2},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Question 1 of 24',
          style: TextStyle(color: Colors.black, fontFamily: 'arial'),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(
          color: Color.fromARGB(
              255, 0, 0, 0), // Set the color of the back arrow here
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, _resetQuiz),
        ),
      ), //Padding
    ); //Scaffold

    ;
  }
}
