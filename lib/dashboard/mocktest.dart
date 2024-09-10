import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/dashboard/mocktestcontent.dart';

class MockTest extends StatefulWidget {
  const MockTest({super.key});

  @override
  State<MockTest> createState() => _MockTestState();
}

class _MockTestState extends State<MockTest> {
  @override
  Widget build(BuildContext context) {
    return MockTestContent();
  }
}
