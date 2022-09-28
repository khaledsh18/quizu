import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/entities/leaders.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/utils/storage.dart';

import '../entities/user.dart';
import '../entities/question.dart';

class NetworkUtils {

  String? getToken(){
    return Storage().getInstance().token;
  }
  Future<int> tokenCheck(token) async {
    await Future.delayed(const Duration(seconds: 1));

    if (token == null) {
      // go to login screen

      return 0;
    }
    var response = await http.get(
        Uri.parse('https://quizu.okoul.com/Token'),
        headers: {
          'Authorization': 'Bearer $token'
        }
    );
    if(response.statusCode == 401){
      // go to login screen
      return 401;
    }
    else if(response.statusCode == 200){
      // go to home page
      return 200;
    }
    return 0;
  }

  Future<int> addNewUser({required String otp, required String mobile}) async {
    var response = await http.post(
        Uri.parse('https://quizu.okoul.com/Login'),
        body: {
          'OTP': otp,
          'mobile': mobile
        }
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      Map<String, dynamic> output = json.decode(response.body);
      await Storage().getInstance().addNewToken(output['token']);
      if(output['user_status'] == 'new'){
        print(response.body);
        return NEW_USER_CODE;
      }else{
        if(output['name'] == null){
          print(response.body);
          return 50;
        }
        print(response.body);
        return RETURNING_USER_CODE;
      }
    }
    return 0;
  }

  Future<void> postName(String name) async {
    String? token = getToken();
    print(token);
    var response = await http.post(
        Uri.parse('https://quizu.okoul.com/Name'),
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          'name': name,
        }
    );
    print(response.body);
  }

  Future<List<Question>> getQuestions() async{
    String? token = getToken();
    var response = await http.get(
        Uri.parse('https://quizu.okoul.com/Questions'),
        headers: {
          'Authorization': 'Bearer $token'
        }
    );

    if(response.statusCode == 200){
      List<dynamic> output = json.decode(response.body);
      return output.map<Question>(Question.fromJson).toList();
    }else{
      return [];
    }
  }

  Future<void> postScore(int score) async{
    String? token = getToken();
    var response = await http.post(
      Uri.parse('https://quizu.okoul.com/Score'),
      headers: {
        'Authorization': 'Bearer $token'
      },
      body: {
        'score' : score.toString()
      }
    );
  }

  Future<List<Leader>> getTopScores() async{
    String? token = getToken();
    var response = await http.get(
        Uri.parse('https://quizu.okoul.com/TopScores'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      List<dynamic> output = json.decode(response.body);
      return output.map<Leader>(Leader.fromJson).toList();
    }else{
      print('response.body');
      return [];
    }
  }

  Future<User> getUserInfo()async{
    String? token = getToken();
    var response = await http.get(
      Uri.parse('https://quizu.okoul.com/UserInfo'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if(response.statusCode == 200){
      dynamic output = jsonDecode(response.body);
      return User.fromJson(output);
    }
    return User(name: 'll', mobile: '55');
  }

}