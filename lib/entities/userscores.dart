import 'package:flutter/material.dart';
import 'package:quizu/entities/score.dart';

class UserScores extends ChangeNotifier{
  List<Score> scoresList = [];


  void addScore(Score score){
    scoresList.add(score);


  }

  void clearScores(){
    scoresList.clear();
  }

}