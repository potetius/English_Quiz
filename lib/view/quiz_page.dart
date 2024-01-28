//view/quiz_page.dart

import 'package:english_quiz/view/result_page.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage(this.quizList, {Key? key}) : super(key: key);
  List<Map> quizList;

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  late List<Map> quizList;
  int index = 0;
  int result = 0;
  bool isSelectNow = true;
  bool _visible = true;

  @override
  void initState() {
    quizList = widget.quizList;
    super.initState();
  }

  // Future<void> updateQuiz(BuildContext context, int selectAnswer) async {
  //   setState(() {
  //     isSelectNow = false;
  //   });
  //   if (quizList[index]["answer"] == selectAnswer) {
  //     result++;
  //   }

  //   await Future.delayed(const Duration(seconds: 1));
  //   isSelectNow = true;
  //   setState(() {});
  //   index++;
  //   if (index == quizList.length) {
  //     await goToResult(context);
  //   }
  //   setState(() {});
  // }

Future<void> updateQuiz(BuildContext context, int selectAnswer) async {
  setState(() {
    isSelectNow = false;
  });
  if (quizList[index]["answer"] == selectAnswer) {
    result++;
  }
  bool isCorrectAnswer = quizList[index]["answer"] == selectAnswer;

  // 1秒待機後、正解かどうかをポップアップで表示
  await Future.delayed(const Duration(milliseconds: 100));

  // ポップアップ表示
  // ignore: use_build_context_synchronously
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          isCorrectAnswer ? '正解！' : '不正解…',
          style: TextStyle(color: isCorrectAnswer ? Colors.green : Colors.red),
        ),
        content: Text(
          '正解は ${quizList[index]["select${quizList[index]["answer"]}"]} でした。',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              isSelectNow = true;
              setState(() {});
              index++;
              if (index == quizList.length) {
                goToResult(context);
              }
            },
            child: const Text('次へ'),
          ),
        ],
      );
    },
  );

  // ポップアップが閉じた後に再度選択可能にする
  isSelectNow = true;
  setState(() {});
}


  Future<void> goToResult(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result(result, quizList.length)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index < quizList.length
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3)),
                    const Text(
                      '問題',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      quizList[index]['question'],
                      //textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25,),
                  ])),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, key) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(double.maxFinite),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (!isSelectNow) return;
                                    await updateQuiz(context, key);
                                  },
                                  child: Text(quizList[index]["select$key"]),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
