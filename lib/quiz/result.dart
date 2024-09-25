import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler; // More specific type

  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  // Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Correct Answer 3/5",
                    textAlign: TextAlign.left,
                  ),
                ),

                Text(
                  'Score: $resultScore',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Text(
                  "Congratulations, you've completed the quiz!",
                  style: TextStyle(
                    // Define the font family
                    fontSize: 20, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                  ),
                  textAlign: TextAlign.center, // Align the text to the center
                ),

                Text(
                  resultPhrase,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ), // Text

                SizedBox(
                  height: 30,
                ),

                Text(
                  "Let's keep testing your knowledge by playing more quizzes",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ), // Text
                Container(
                  width: double.infinity, // Cover the full width of the page
                  decoration: BoxDecoration(
                    color:
                        Color.fromARGB(255, 180, 52, 255), // Background color
                    borderRadius:
                        BorderRadius.circular(15), // Curve the corners
                  ),
                  child: TextButton(
                    onPressed:
                        resetHandler, // Pass the function reference directly
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(14), // Padding inside the button
                      primary: Colors.white, // Text color
                      backgroundColor: Colors
                          .transparent, // Background color is handled by Container
                    ),
                    child: const Text(
                      'Restart Quiz',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )

                // TextButton is used instead of FlatButton
              ], //<Widget>[]
            ),
          ),
        ),
      ), // Column
    ); // Center
  }
}
