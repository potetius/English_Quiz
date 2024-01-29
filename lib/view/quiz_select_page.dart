import 'package:english_quiz/service/load_csv.dart';
import 'package:english_quiz/service/suffle.dart';
import 'package:english_quiz/view/quiz_page.dart';
import 'package:english_quiz/view/quiz_view_page.dart';
import 'package:flutter/material.dart';

class QuizSelect extends StatelessWidget {
  const QuizSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (int i = 1; i < 4; i++) ...{
          QuizButton(quizNo: i),
        }
      ]),
    );
  }
}

class QuizButton extends StatelessWidget {
  QuizButton({super.key, required this.quizNo});

  final int quizNo;
  late List<Map> quizList;

  Future<void> goToQuizApp(BuildContext context) async {
    quizList = shuffle(await getCsvData('assets/quiz$quizNo.csv'));
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
                showDialog<String>(
                  context: context,
                  builder: (_) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                          child: const Text('QuizView'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizData(quizNo: quizNo)));
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('Answer a Question'),
                          onPressed: () {
                            goToQuizApp(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Text('Quiz$quizNo')),
        ],
      ),
    );
  }
}
