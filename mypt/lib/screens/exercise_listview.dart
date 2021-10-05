import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_tile.dart';
import 'package:mypt/utils/build_appbar.dart';

class ExerciseListView extends StatelessWidget {
  final Map<String, Map<String, dynamic>>? exerciseList;

  ExerciseListView({@required this.exerciseList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: exerciseList!.length,
          itemBuilder: (ctx, index) {
            var name = exerciseList!.keys.toList()[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ExerciseTile(
                workoutName: name,
                nextPage: exerciseList![name]!['nextPage'],
              ),
            );
          },
        ),
      ),
    );
  }
}
