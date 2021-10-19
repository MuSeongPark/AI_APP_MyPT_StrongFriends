import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:mypt/components/workout_result_grid.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/utils/build_no_titled_appbar.dart';

class WorkoutResultDemoListPage extends StatefulWidget { // demo of result list page
  @override
  _WorkoutResultDemoListPageState createState() => _WorkoutResultDemoListPageState();
}

class _WorkoutResultDemoListPageState extends State<WorkoutResultDemoListPage> {
  WorkoutResult workoutResult1 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'push_up', count: 16, feedbackCounts: [1,4,0,3,0,1], score: [1358]);
  WorkoutResult workoutResult2 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'pull_up', count: 6, feedbackCounts: [0,0,0,2,2], score: [100,100,100,100,75,75]);
  WorkoutResult workoutResult3 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'squat', count: 12, feedbackCounts: [2,2,3,1,4,2], score: [100,50,100,60,70,80,40,50,60,100,80,90]);
  WorkoutResult workoutResult4 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'push_up', count: 15, feedbackCounts: [0,2,3,4,1,4], score: [100,50,100,60,70,80,40,50,60,100,100,100,100]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
            children: 
              [
              WorkoutResultGrid(workoutResult: workoutResult1),
              WorkoutResultGrid(workoutResult: workoutResult2),
              WorkoutResultGrid(workoutResult: workoutResult3),
              WorkoutResultGrid(workoutResult: workoutResult4),
              ],
              padding: const EdgeInsets.all(5.0) ,
            )
          ),
    );
  }
  }
