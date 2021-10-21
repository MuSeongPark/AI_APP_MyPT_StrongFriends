import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/components/leaderboard_tile.dart';
import 'package:mypt/theme.dart';

class LeaderBoardDemoPage extends StatelessWidget {
  // demo of leaderboard page
  static const Map<String, int> leaderBoardData = {
    '김강민': 3240,
    '박서준': 3000,
    '유민준': 2970,
    '박주원': 2810,
    '김민혁': 2700,
    '차태현': 2630,
    '정은우': 2600,
    '전도윤': 2570,
    '윤시우': 2400,
  };
  Future<void> getleaderboard() async {
    List<String> name = [];
    List<int> score = [];
    await FirebaseFirestore.instance
        .collection('leaderboard_DB')
        .orderBy('score', descending: true)
        .limit(10)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((doc) {
        name.add(doc['name']);
        score.add(doc['score']);
      });
    });
    for (var i = 0; i < name.length; i++) {
      leaderBoardData.keys.toList()[i] = name[i];
      leaderBoardData.values.toList()[i] = score[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LineAwesomeIcons.trophy,
                size: 20,
                color: Colors.yellow[700],
              ),
              const SizedBox(width: 5),
              Text(
                '리더보드',
                style: header,
              ),
              const SizedBox(width: 5),
              Icon(
                LineAwesomeIcons.trophy,
                size: 20,
                color: Colors.yellow[700],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: List.generate(leaderBoardData.length, (index) {
                return LeaderBoardTile(
                    userName: leaderBoardData.keys.toList()[index],
                    score: leaderBoardData.values.toList()[index],
                    rank: index + 1);
              }),
            ),
          )
          /*
          SingleChildScrollView(
            child: ListView(
              children: List.generate(5, (index) {
                return LeaderBoardTile(score: 100.0 - index, rank: index + 1);
              }),
            )
          )
          */
        ],
      ),
    );
  }
}
