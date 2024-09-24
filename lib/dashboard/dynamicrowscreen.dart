import 'package:flutter/material.dart';
import 'package:online_quiz_app/constant.dart';
import 'package:online_quiz_app/quiz/quizhome.dart';

class DynamicRowScreen extends StatelessWidget {
  // List of objects with image URL, name, and description
  final List<Map<String, String>> items = [
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 1',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 2',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 3',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 4',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 5',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 6',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 7',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 8',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 9',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 10',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 11',
      'desc': 'Introduction',
    },
    {
      'image': 'assets/docs.png',
      'name': 'Chapter 12',
      'desc': 'Introduction',
    },
    // Add more chapters as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Split the items into chunks of 3 for each row
    List<List<Map<String, String>>> rows = [];
    for (var i = 0; i < items.length; i += 3) {
      rows.add(items.sublist(i, i + 3 > items.length ? items.length : i + 3));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dynamically generate rows
              ...rows.asMap().entries.map((rowEntry) {
                int rowIndex = rowEntry.key;
                List<Map<String, String>> rowItems = rowEntry.value;

                return Row(
                  children: rowItems.asMap().entries.map((entry) {
                    int columnIndex = entry.key;
                    Map<String, String> item = entry.value;

                    // Calculate the dynamic chapter number
                    int chapterNumber = rowIndex * 3 + columnIndex + 1;

                    return Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QuizHome(),
                            ));
                          },
                          child: Container(
                            color: quizback,
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    'C$chapterNumber', // Dynamic chapter number
                                    style: const TextStyle(
                                        color: quiztite,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['name']!, // Name from list
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: quizhead,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    item['desc']!, // Description from list
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14, color: quizdesc),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
