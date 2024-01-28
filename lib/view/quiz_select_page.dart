import 'package:english_quiz/service/load_csv.dart';
import 'package:english_quiz/service/suffle.dart';
import 'package:english_quiz/view/quiz_page.dart';
import 'package:flutter/material.dart';

class QuizSelect extends StatelessWidget {
  const QuizSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Quiz1App(),
          Quiz2App()
        ],),
    );
  }
}

class Quiz1App extends StatelessWidget {
  Quiz1App({Key? key}) : super(key: key);
  late List<Map> quizList;

  Future<void> goToQuizApp(BuildContext context) async {
    quizList = shuffle(await getCsvData('assets/quiz1.csv'));
    for (Map row in quizList) {
      debugPrint(row["question"]);
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuizPage(quizList)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //Columnの中に入れたものは縦に並べられる．Rowだと横に並べられる
        mainAxisAlignment: MainAxisAlignment.center, //Coloumの中身を真ん中に配置
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                //goToQuizApp(context); //クイズアプリへ遷移するQuizApp関数がよばれる
              },
              child: const Text('Quiz1')),
        ],
      ),
    );
  }
}

class Quiz2App extends StatelessWidget {
  Quiz2App({Key? key}) : super(key: key);
  late List<Map> quizList;

  Future<void> goToQuizApp(BuildContext context) async {
    quizList = shuffle(await getCsvData('assets/quiz2.csv'));
    for (Map row in quizList) {
      debugPrint(row["question"]);
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuizPage(quizList)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //Columnの中に入れたものは縦に並べられる．Rowだと横に並べられる
        mainAxisAlignment: MainAxisAlignment.center, //Coloumの中身を真ん中に配置
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                goToQuizApp(context); //クイズアプリへ遷移するQuizApp関数がよばれる
              },
              child: const Text('Quiz1')),
        ],
      ),
    );
  }
}