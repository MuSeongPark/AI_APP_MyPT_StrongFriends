import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
//import 'package:testapp/workout_result_grid.dart';
import 'package:testapp/workout_result.dart';
import 'package:testapp/workout_result_page.dart';
import 'package:get/get.dart';
import 'package:testapp/build_no_title_appbar.dart';
import 'package:testapp/workout_result_grid.dart';

class WorkoutResultListPage extends StatefulWidget {
  @override
  _WorkoutResultListPageState createState() => _WorkoutResultListPageState();
}

class _WorkoutResultListPageState extends State<WorkoutResultListPage> {
  WorkoutResult workoutResult1 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'push_up', count: 20, feedbackCounts: [0,5,3,2,1,7], score: [100,50,100,60,70,80,40,50,60,100,100,50,100,60,70,80,40,50,60,100]);
  WorkoutResult workoutResult2 = WorkoutResult(uid: 'a', user: 'mingu', workoutName: 'pull_up', count: 10, feedbackCounts: [1,4,2,4,3], score: [100,50,100,60,70,80,40,50,20,20]);
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
