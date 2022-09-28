import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizu/utils/constants.dart';
import 'package:share_plus/share_plus.dart';

class QuizResult extends StatefulWidget {
  static String id = 'quiz_result';
  const QuizResult({Key? key}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  @override
  Widget build(BuildContext context) {
    final correctAnswers = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
        actions: [
          IconButton(onPressed:() => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Text(
                'Congrats!',
                style: kTextStyle.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w600
                ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1 ),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: MediaQuery.of(context).size.height *0.25
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'You have completed',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(color: secondaryColor),
                      ),
                      Text(
                        '$correctAnswers',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(color: secondaryColor, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'correct answers',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(color: secondaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      Share.share('I answered $correctAnswers correct answers in QuizU!');
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: secondaryColor))),
                    ),
                    child: Row(children: [Icon(Icons.share),Text(
                      ' Share',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    )],)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
