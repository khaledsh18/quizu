import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/entities/userscores.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/screens/login/login.dart';
import 'package:quizu/utils/networkutils.dart';
import 'package:quizu/utils/storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../entities/score.dart';
import '../../entities/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String mobile = '';
  List<ScoreTile> scoreTiles = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<UserScores>(
        builder: (context,userScores, child){
          setScoreTiles(userScores);
          if(name.isEmpty){
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
                )
            );
          }
          else{
            return Scaffold(
                body: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),child: Text('Name: $name',textAlign:TextAlign.center,style: kTextStyle,)),
                    Text('Mobile: $mobile',textAlign:TextAlign.center,style: kTextStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.08,
                          color: white,
                          onPressed: (){
                            changNameDialog();
                          }, icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          iconSize: MediaQuery.of(context).size.width * 0.08,
                          color: white,
                          onPressed: (){
                            Storage().getInstance().removeToken();
                            Navigator.pushReplacementNamed(context, LoginScreen.id);},
                          icon: Icon(Icons.logout),
                        )
                      ],
                    ),
                    const Divider(color: white),
                    Text('My Scores',textAlign:TextAlign.center,style: kTextStyle,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: scoreTiles.reversed.toList(),
                        ),
                      ),
                    )
                  ],
                )
            );
          }
        }
    );
  }

  void changNameDialog() {
    String newName ='';
    Alert(
        context: context,
        title: "Change Name",
        content: TextField(
          onChanged: (value){
            newName = value;
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.account_circle),
            labelText: 'Name',
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async{
              await NetworkUtils().postName(newName);
              getUserInfo();
              Navigator.pop(context);
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async{
    User user = await NetworkUtils().getUserInfo();
    setState((){
      name = user.name;
      mobile = user.mobile;
    });
  }

  void setScoreTiles(UserScores userScores) {
    scoreTiles.clear();
    for(int i=0; i < userScores.scoresList.length; i++){
      scoreTiles.add(ScoreTile(date: userScores.scoresList[i].date, score: userScores.scoresList[i].score));
    }
  }
}

class ScoreTile extends StatelessWidget {
  final String date;
  final String score;
  const ScoreTile({Key? key, required this.date, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.07),
            child: Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.45,
                    maxWidth: MediaQuery.of(context).size.width * 0.45
                ),
                child: Text(date,textAlign: TextAlign.center, style: kTextStyle.copyWith(fontSize: 20,color: secondaryColor))),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
              child: Text(score, style: kTextStyle.copyWith(fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}




