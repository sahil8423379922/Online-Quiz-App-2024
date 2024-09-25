import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    // Function to speak the answer text
    Future<void> _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(answerText);
    }

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
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 60.0, // Minimum height of the option
            ),
            child: TextButton(
              onPressed: selectHandler,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 241, 241, 241)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        answerText,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.black),
                      onPressed: _speak, // Speak the text when icon is clicked
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
