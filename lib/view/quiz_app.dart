
//view/quiz_app.dart
import 'package:english_quiz/view/quiz_select_page.dart';
import 'package:flutter/material.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizSelect()));
                },
                child: const Text('QuizSelect')),
          ],
        ),
      ),
    );
  }
}
