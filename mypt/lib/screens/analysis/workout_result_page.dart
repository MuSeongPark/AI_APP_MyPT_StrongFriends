import 'package:flutter/material.dart';
import 'package:mypt/components/customized_bar_chart.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';
import 'package:mypt/models/workout_result.dart';

class WorkoutResultPage extends StatelessWidget {
  WorkoutResultPage({Key? key, required this.workoutResult}) : super(key: key);
  WorkoutResult workoutResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CustomizedBarChart(
                workoutResult: workoutResult,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    color: kLightIvoryColor,
                    child: Center(
                      child: _buildFeedback(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    if (workoutResult.workoutName == 'squat') {
      return Text('Squat Feedback');
    } else {
      return Text('피드백');
    }
  }
}
