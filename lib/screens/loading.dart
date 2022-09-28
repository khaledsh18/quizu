import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quizu/utils/networkutils.dart';
import 'package:quizu/screens/login/login.dart';
import 'package:quizu/screens/main/main.dart';
import 'package:quizu/utils/storage.dart';

import 'package:quizu/test.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loading_screen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    tokenCheck();
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.lightBlueAccent,
            strokeWidth: 10,
          ),
        ),
      ),
    );
  }

  tokenCheck() async {
    await Storage().getInstance().setToken();
    String? token = Storage().getInstance().token;
    print(token);

    int responseCode = await NetworkUtils().tokenCheck(token);
    print(responseCode);
    if (responseCode == 0){
      // go to login screen
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,(e) => false);
    }
    else if(responseCode == 401){
      // go to login screen
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,(e) => false);
    }
    else if (responseCode == 200){
      // go to home page
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id,(e) => false);
    }
  }


}