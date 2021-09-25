import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';
import 'pose_detector_view.dart';

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
          IconButton(onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PoseDetectorView()));
          }, icon: const Icon(Icons.camera))
        ],
      ),
    );
  }
}
