import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/screens/login/checkcode.dart';
import 'package:phone_number/phone_number.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber = '+966';
  bool _isValid = false;
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  final _validationKey = GlobalKey<FormState>();

  Future<void> validateNumber(String phone) async{

    String phoneNumber = '+966$phone';
    // Validate
    _isValid = await PhoneNumberUtil().validate(phoneNumber);
  }
  
  Future<String> formattedPhoneNumber(String phone) async{
    String phoneNumb = '+966$phone';
    
    PhoneNumber phoneNumber = await PhoneNumberUtil().parse(phoneNumb);
    
    return phoneNumber.nationalNumber;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await validateNumber(phoneNumber);
            _validationKey.currentState?.validate();
            if(_isValid){
              Navigator.pushNamed(context, CheckCode.id,arguments: await formattedPhoneNumber(phoneNumber));
            }else{
              phoneFocus.unfocus();
            }
          },
          backgroundColor: const Color(0xff4c505b),
          child: Icon(Icons.arrow_forward),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: const Text(
                  'QuizU',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: Colors.white),
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: MediaQuery.of(context).size.height * 0.20),
              child: const Text(
                'Enter your phone number ',
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35,right: 35, top: 10),
              child: Form(
                key: _validationKey,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty || value.length < 9){
                      return('Please enter a valid phone number');
                    }
                    if(!_isValid){
                      return ('Number is invalid');
                    }
                  },
                  focusNode: phoneFocus,
                  controller: phoneController,
                  onChanged: (value) {
                    setState((){
                      phoneNumber = value;
                    });
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  decoration: const InputDecoration(
                    errorBorder: kErrorBorder,
                    prefixText: '+966',
                    prefixStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                    ),
                    focusedBorder: kFocusBorder,
                    border: kBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '55 666 7777',
                  ),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
