
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:provider/provider.dart';
import 'package:quizu/entities/score.dart';
import 'package:quizu/entities/userscores.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/screens/main/main.dart';
import 'package:quizu/screens/quiz/quizresult.dart';
import 'package:quizu/utils/networkutils.dart';
import 'package:quizu/utils/storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../entities/question.dart';

class QuizPage extends StatefulWidget {
  static String id = 'quiz_page';
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const maxSeconds = 60;
  static const maxMin = 1;
  int seconds = maxSeconds;
  int min = maxMin;
  Timer? timer;

  List<Question> questions = [];
  String question = '';
  String a = '';
  String b = '';
  String c = '';
  String d = '';
  String correct = '';
  bool isSkipped = false;
  int n = 0;
  int correctAnswers = 0;
  // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  // DateTime dateTime = DateTime.now().add(const Duration(minutes: 2,seconds: 00));

  void startTimer(){
    timer = Timer.periodic( const Duration(seconds: 1), (_) {
      if(seconds > 0){
      setState(() => seconds--);
      }else{
        if(min == 1){
          setState((){
            min = 0;
            seconds = 59;
          });
        }else{
          onEnd();
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    final questions = ModalRoute.of(context)!.settings.arguments as List<Question>;
    setWidgets(questions);
    return Consumer<UserScores>(
        builder: (context, userScores, child){
          if(seconds == 0){
            var now = DateTime.now();
            var formatter = DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(now);
            userScores.addScore(Score(formattedDate, correctAnswers.toString()));
          }
          return Scaffold(
            backgroundColor: grey,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: buildTimer(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: MediaQuery.of(context).size.height *0.25
                        ),
                        child:Center(child: Text(
                          question,
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))
                        ),
                        constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: MediaQuery.of(context).size.height * 0.44
                        ),
                        child: Column(
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44 *0.06),
                              child: QuizPageButton(
                                  onPressed: (){
                                    checkAnswer('a',questions);
                                  },
                                  text:a
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44 *0.05),
                              child: QuizPageButton(
                                  onPressed: (){
                                    checkAnswer('b',questions);
                                  },
                                  text:b
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44 *0.05),
                              child: QuizPageButton(
                                  onPressed: (){
                                    checkAnswer('c',questions);
                                  },
                                  text: c),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44 *0.05),
                              child: QuizPageButton(
                                  onPressed: (){
                                    checkAnswer('d',questions);
                                  },
                                  text: d),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.44 *0.05, bottom: MediaQuery.of(context).size.height * 0.44 *0.05),
                              child: TextButton(
                                onPressed: (){
                                  if(isSkipped){
                                    return;
                                  }else{
                                    setState((){
                                      n++;
                                      isSkipped = true;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                                  backgroundColor: MaterialStateProperty.all<Color>(white),
                                  foregroundColor: MaterialStateProperty.all<Color>(isSkipped? grey : secondaryColor),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: white))),
                                ),
                                child: const Text(
                                  'skip',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Widget buildTimer(){
    if(min == 1){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Remaining Time',textAlign: TextAlign.center, style: kTextStyle,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10),),

                ),
                child: Text('$min \n minute',textAlign: TextAlign.center,style: kTextStyle.copyWith(color: white),),
              ),
              const SizedBox(width: 15,),
              Container(
                padding:const EdgeInsets.all(8.0),
                decoration:const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Text('$seconds \n seconds',textAlign: TextAlign.center,style: kTextStyle.copyWith(color: secondaryColor),),
              )
            ],
          )
        ],
      );
    }else{
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Remaining Time',textAlign: TextAlign.center, style: kTextStyle,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Text('$seconds \n seconds',textAlign: TextAlign.center,style: kTextStyle.copyWith(color: secondaryColor),),
              )
            ],
          )
        ],
      );
    }
  }
  void setWidgets(List<Question> questions) {
    question =  questions[n].question;
    a = questions[n].answerA;
    b = questions[n].answerB;
    c = questions[n].answerC;
    d = questions[n].answerD;
    correct = questions[n].correctAnswer;
  }

  void checkAnswer(String a, List<Question> questions,) {
    if(a == correct){
      if (n<questions.length-1){
        setState((){
          correctAnswers ++;
          n++;
          setWidgets(questions);
        });
      }else{
        correctAnswers++;
        onEnd();
      }
    }else{
      stopTimer();
      showAlert(questions);
    }
  }

  void showAlert(List<Question> questions) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Wrong Answer",
      desc: "Good luck next time :)",
      closeFunction: (){
        Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (e) => false);
      },
      buttons: [
        DialogButton(
          onPressed: () {
            setState((){
              n = 0;
              correctAnswers = 0;
              isSkipped = false;
              seconds = maxSeconds;
              min = maxMin;
              startTimer();
              // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
            });
            setWidgets(questions);
            Navigator.pop(context);
          },
          color: Colors.green,
          child: const Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () {

            Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (e) => false);
          },
          color: secondaryColor,
          child: const Text(
            "Home",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void stopTimer() {
    timer!.cancel();
  }

  void onEnd() {
    Navigator.pushReplacementNamed(context, QuizResult.id,arguments: correctAnswers);
    NetworkUtils().postScore(correctAnswers);
    stopTimer();
  }
}

class QuizPageButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const QuizPageButton(
      {Key? key,
        required this.onPressed,
        required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.44 /5;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: secondaryColor))),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        maximumSize: MaterialStateProperty.all<Size>(Size(width, height))
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}