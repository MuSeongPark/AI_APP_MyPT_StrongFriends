import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypt/components/workout_result_grid.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/screens/analysis/workout_result_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:get/get.dart';
import 'package:mypt/utils/build_no_titled_appbar.dart';

class WorkoutResultListPage extends StatefulWidget {
  @override
  _WorkoutResultListPageState createState() => _WorkoutResultListPageState();
}

class _WorkoutResultListPageState extends State<WorkoutResultListPage> {
  final Stream<QuerySnapshot> _resultsStream =
      FirebaseFirestore.instance.collection('exercise_DB').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: _buildStreamBuilder(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildStreamBuilder() {
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
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              WorkoutResult workoutResult = WorkoutResult.fromJson(data);
              return ListTile(
                  title: Text(workoutResult.workoutName!),
                  subtitle: Text('${workoutResult.sumOfScore()}'),
                  onTap: () {
                    Get.to(WorkoutResultPage(workoutResult: workoutResult));
                  });
            }).toList(),
          );
      },
    );
  }
}
