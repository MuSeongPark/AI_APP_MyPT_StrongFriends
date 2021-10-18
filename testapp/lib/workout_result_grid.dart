import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/workout_result.dart';
import 'package:testapp/main.dart';
import 'package:testapp/workout_result_page.dart';

class WorkoutResultGrid extends StatelessWidget {
  late WorkoutResult workoutResult;
  late Color backgroundColor;
  final textStyle = const TextStyle(
      fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 15);

  WorkoutResultGrid({required this.workoutResult});
  

  // ignore: use_key_in_widget_constructors
  // WorkoutResultGrid(WorkoutResult workoutResult){
  //   if (workoutResult.workoutName == 'push_up'){
  //     backgroundColor = colorList[0];
  //   } else if (workoutResult.workoutName == 'pull_up'){
  //     backgroundColor = colorList[1];
  //   } else if (workoutResult.workoutName == 'squat'){
  //     backgroundColor = colorList[2];
  //   } else {
  //     backgroundColor = colorList[2];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkoutResultPage(workoutResult: workoutResult,)),
          );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 120,
        width: double.infinity,
        child: Row(
          children: [_buildWorkoutName(), const Spacer(), _buildRecord()],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 7.0) // changes position of shadow
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutName() {
    return Text('${workoutResult.workoutName}'.toUpperCase(), style: textStyle);
  }

  Widget _buildRecord() {
    int sum = 0;
    for (int i=0; i<workoutResult.score!.length; i++){
      sum += workoutResult.score![i];
    }
    int count = workoutResult.count!;
    return Column(
      children: [
        Text('운동횟수 : $count', style: textStyle),
        Text('운동점수 : $sum', style: textStyle),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
