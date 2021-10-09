import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/components/leaderboard_tile.dart';
import 'package:mypt/theme.dart';

class LeaderBoardPage extends StatelessWidget {
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
                'Leaderboard',
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
              children: List.generate(5, (index) {
                return LeaderBoardTile(score: 100.0 - index, rank: index + 1);
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
