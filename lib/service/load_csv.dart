//service/load_csv.dart

import 'package:english_quiz/model/quiz.dart';
import 'package:flutter/services.dart';

Future<List<Map>> getCsvData(String path) async {
  List<Map> quizList = [];
  String csv = await rootBundle.loadString(path);

  // Splitting the CSV into lines
  List<String> lines = csv.split("\n");

  // Remove the last empty line (if any)
  if (lines.isNotEmpty && lines.last.isEmpty) {
    lines.removeLast();
  }

  for (String line in lines) {
    List<String> rows = line.split(',');

    // Ensure the row has enough elements before accessing them
    if (rows.length >= 6) {
      Quiz quiz = Quiz(
        rows[0],
        int.parse(rows[1]),
        rows[2],
        rows[3],
        rows[4],
        rows[5],
      );

      quizList.add(quiz.toMap());
    } else {
      // Handle the case where the row doesn't have enough elements
      print("Invalid row: $line");
    }
  }

  return quizList;
}
