import 'package:flutter/material.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/screens/quiz/quizpage.dart';

import '../../entities/question.dart';
import '../../utils/networkutils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Question> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ready to test your \n knowledge and challenge \n others ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () async{
                  await getQuestion();
                  Navigator.pushNamed(context, QuizPage.id,arguments: questions);
                },
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondaryColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: secondaryColor))),
                ),
                child: const Text(
                  'Quiz Me',
                  style: kTextStyle,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Answer as much questions \n correctly within 2 minutes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  Future<void> getQuestion() async{
    questions = await NetworkUtils().getQuestions();
  }
}


