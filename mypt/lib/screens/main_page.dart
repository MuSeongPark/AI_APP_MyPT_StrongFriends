import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 5),
          SizedBox(width: 5),
          ExerciseGrid(muscle: 'Chest'),
        ],
      ),
    );
  }
}
