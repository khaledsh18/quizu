import 'package:flutter/material.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/utils/networkutils.dart';

import '../../entities/leaders.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Leader> leadersList = [];
  List<LeaderboardTile> tiles = [];
  @override
  Widget build(BuildContext context) {
    if(leadersList.isEmpty){
      return const Scaffold(
        body:Center(
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
    }else{
      return Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              child: Row(
                children: [
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
                  //           child: Text('3', style: kTextStyle.copyWith(fontSize: 20),)),
                  //       Text(leadersList[2].name,maxLines:1,style: kTextStyle.copyWith(fontSize: 20),),
                  //       Text(leadersList[2].score.toString(), style: kTextStyle.copyWith(fontSize: 17),)
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3,
                            left:MediaQuery.of(context).size.width * 0.3, bottom: MediaQuery.of(context).size.height * 0.02),
                            child: Image(image: AssetImage('assets/images/crown1.png'))),
                        Text(leadersList[0].name,maxLines:1,style: kTextStyle,),
                        Text(leadersList[0].score.toString(),style: kTextStyle.copyWith(fontSize: 20),)
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
                  //           child: Text('2', style: kTextStyle.copyWith(fontSize: 20),)),
                  //       Text(leadersList[1].name,maxLines:1,style: kTextStyle.copyWith(fontSize: 20),),
                  //       Text(leadersList[1].score.toString(), style: kTextStyle.copyWith(fontSize: 17),)
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: tiles,
                ),
              ),
            )
          ],
        ),
      );
    }

  }


  @override
  void initState() {
    super.initState();
    setScores();
  }

  Future<List<Leader>> getTopScores() async{
    return await NetworkUtils().getTopScores();
  }

  void setLeadersTiles(List<Leader> list) {
    for(int i = 1;i<list.length;i++){
      setState((){
        tiles.add(LeaderboardTile(pos: '${i+1}.', name: list[i].name, score: list[i].score.toString()));
      });
    }
  }

  void setScores() async{
    leadersList = await getTopScores();
    setLeadersTiles(leadersList);
  }
}

class LeaderboardTile extends StatelessWidget {
  final String pos;
  final String name;
  final String score;

  const LeaderboardTile({Key? key, required this.pos, required this.name, required this.score}) : super(key: key);

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
                  minWidth: MediaQuery.of(context).size.width * 0.15
                ),
                child: Text(pos,textAlign: TextAlign.center, style: kTextStyle.copyWith(fontSize: 20,color: secondaryColor))),
          ),
          Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  maxWidth: MediaQuery.of(context).size.width * 0.45
              ),
              child: Text(name,textAlign: TextAlign.center, style: kTextStyle.copyWith(fontSize: 20,color: secondaryColor))),
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

