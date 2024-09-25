import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int resultScore;
  final VoidCallback resetHandler; // More specific type
  final int length;
  final int correctAnswers;

  const Result(this.resultScore, this.resetHandler,
      {Key? key, required this.length, required this.correctAnswers})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  // Remark Logic
  String get resultPhrase {
    String resultText;
    if (widget.resultScore >= 41) {
      resultText = 'You are awesome!';
      print(widget.resultScore);
    } else if (widget.resultScore >= 31) {
      resultText = 'Pretty likable!';
      print(widget.resultScore);
    } else if (widget.resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (widget.resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(widget.resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(
                        8.0), // Adds padding inside the strip
                    // Adds space around the strip
                    color: Colors.blue, // Background color of the strip
                    child: Text(
                      "Correct Answer ${widget.correctAnswers}/${widget.length}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Text size
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),

                SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/podium.png')),

                Text(
                  'Score : ${widget.resultScore}',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Congratulations, you've completed the quiz!",
                    style: TextStyle(
                      // Define the font family

                      fontSize: 18, // Set the font size
                      fontWeight: FontWeight.bold, // Set the font weight
                    ),
                    textAlign: TextAlign.center, // Align the text to the center
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // Text(
                //   resultPhrase,
                //   style: const TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.normal),
                //   textAlign: TextAlign.center,
                // ), // Text

                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Let's keep testing your knowledge by playing more quizzes",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 20,
                ), // Text
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    width: double.infinity, // Cover the full width of the page
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 180, 52, 255), // Background color
                      borderRadius:
                          BorderRadius.circular(15), // Curve the corners
                    ),
                    child: TextButton(
                      onPressed: widget
                          .resetHandler, // Pass the function reference directly
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.all(14), // Padding inside the button
                        primary: Colors.white, // Text color
                        backgroundColor: Colors
                            .transparent, // Background color is handled by Container
                      ),
                      child: const Text(
                        'Restart Quiz',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
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
