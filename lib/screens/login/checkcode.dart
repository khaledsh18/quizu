import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/utils/networkutils.dart';
import 'package:quizu/screens/login/name.dart';
import 'package:quizu/screens/main/main.dart';

class CheckCode extends StatefulWidget {
  static String id = 'check_screen';
  const CheckCode({Key? key}) : super(key: key);

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    final mobileNumber = ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: const Color(0xff4c505b),
          child: Icon(Icons.arrow_forward),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                child: const Text(
                  'QuizU',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: Colors.white
                  ),
                )
            ),

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Text('We sent OTP to +966 $mobileNumber')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: OtpTextField(
                filled: true,
                fillColor: Colors.white,
                fieldWidth: MediaQuery.of(context).size.width / 5,
                numberOfFields: 4,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(10),
                enabledBorderColor: Colors.white,
                focusedBorderColor: grey,
                cursorColor: grey,
                textStyle: const TextStyle(
                    fontSize: 25
                ),
                onCodeChanged: (value){

                },
                onSubmit: (value){
                  otp = value;
                  checkOtp(
                    otp: otp,
                    mobile: mobileNumber
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkOtp({required String otp, required String mobile}) async{
    int responseCode = await NetworkUtils().addNewUser(otp: otp, mobile: mobile);

    if (responseCode == NEW_USER_CODE){
      Navigator.pushNamed(context, NameScreen.id);
    }
    else if (responseCode == RETURNING_USER_CODE){
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id,(e) => false);
    }
    else if(responseCode == 50){
      Navigator.pushNamed(context, NameScreen.id);
    }
  }
}
