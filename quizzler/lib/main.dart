import 'package:flutter/material.dart';
import 'package:quizzler/Quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkInput(bool userPickedAnswer) {
    setState(() {
      if (quizBrain.getQuestionAnswer() == userPickedAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      }
      if (!quizBrain.nextQuestion()) {
        Alert(
            context: context,
            type: AlertType.success,
            title: 'Quiz ended',
            desc: 'Do you want to restart the quiz?',
            buttons: [
              DialogButton(
                onPressed: () {
                  setState(() {
                    scoreKeeper = [];
                    quizBrain.resetQuiz();
                    Navigator.pop(context);
                  });
                },
                child: Text('Ok'),
                height: 50.0,
              )
            ]).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.green,
            child: FlatButton(
              onPressed: () {
                checkInput(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.red,
            child: FlatButton(
              onPressed: () {
                checkInput(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
