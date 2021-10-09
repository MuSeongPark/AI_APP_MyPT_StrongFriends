import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';

class LeaderBoardTile extends StatelessWidget {
  final String? userName;
  final double? score;
  final int? rank;

  LeaderBoardTile({
    this.userName,
    required this.score,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.deepPurple, width: 0.5),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  '$rank',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$userName',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: Text(
                  '$score',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
