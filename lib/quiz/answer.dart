import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler; // More specific type
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use SizedBox for white space instead of Container
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black), // Set the border color and width
            borderRadius:
                BorderRadius.circular(5), // Optional: round the corners
          ),
          child: TextButton(
            onPressed: selectHandler, // Pass the function reference directly
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 241, 241, 241)),
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answerText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    ); // SizedBox
  }
}
