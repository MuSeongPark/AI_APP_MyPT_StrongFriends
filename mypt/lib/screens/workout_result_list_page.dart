import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypt/components/workout_result_grid.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/screens/analysis/old_bar_chart_page.dart';
import 'package:mypt/screens/analysis/result_page.dart';
import 'package:mypt/screens/analysis/bar_chart_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:get/get.dart';

class WorkoutResultListPage extends StatefulWidget {
  @override
    _WorkoutResultListPageState createState() => _WorkoutResultListPageState();
}

class _WorkoutResultListPageState extends State<WorkoutResultListPage> {
  final Stream<QuerySnapshot> _resultsStream = FirebaseFirestore.instance.collection('exercise_DB').snapshots();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _resultsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          WorkoutResult workoutResult = WorkoutResult.fromJson(data);
          // return WorkoutResultGrid(workoutResult);
          return ListTile(
            title: Text(data['workout_name']),
            onTap: (){
              Get.to(ResultPage3(workoutResult: workoutResult));
            }
          );
          }).toList(),
        );
      },
    );
  }
}

