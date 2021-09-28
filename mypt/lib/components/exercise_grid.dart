import 'package:flutter/material.dart';

class ExerciseGrid extends StatelessWidget {
  final String? muscle;
  final nextPage;
  ExerciseGrid({@required this.muscle, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        width: 150,
        child: Column(
          children: [
            Text('$muscle'),
            Spacer(),
            Image.asset(
              '$muscle.jpg',
              fit: BoxFit.fitWidth,
              height: 150,
            ),
            // Link: https://www.flaticon.com/search?word=pushup&license=selection&style=all&order_by=4&type=icon
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffDDF2FF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 7.0) // changes position of shadow
                ),
          ],
        ),
      ),
    );
  }
}
