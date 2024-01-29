import 'package:english_quiz/service/load_csv.dart';
import 'package:flutter/material.dart';

class QuizView extends StatelessWidget {
  final List<Map> quizList;

  QuizView({Key? key, required this.quizList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Data'),
      ),
      body: ListView.builder(
        itemCount: quizList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(quizList[index]["question"].toString()),
            subtitle: Text('Answer: ${quizList[index]["select${quizList[index]["answer"]}"]}'),
          );
        },
      ),
    );
  }
}

class QuizData extends StatefulWidget {
  final int quizNo; // quizNo パラメータを追加

  QuizData({Key? key, required this.quizNo}) : super(key: key);

  @override
  _QuizDataState createState() => _QuizDataState(quizNo: quizNo); // quizNo パラメータを渡す
}

class _QuizDataState extends State<QuizData> {
  _QuizDataState({required this.quizNo});
  late List<Map> quizList;
  final int quizNo;

  // initState メソッドで CSV データを読み込む
  @override
  void initState() {
    super.initState();
    loadQuizData();
  }

  // CSV データを読み込む関数
  Future<void> loadQuizData() async {
    quizList = await getCsvData('assets/quiz$quizNo.csv');
    setState(() {}); // データが読み込まれたことを反映するために setState を呼ぶ
  }

  // QuizView を表示するメソッド
  void showQuizView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizView(quizList: quizList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Select'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showQuizView(); // ボタンが押されたら QuizView を表示
              },
              child: Text('ほんとに見るの ？？'),
            ),
          ],
        ),
      ),
    );
  }
}
