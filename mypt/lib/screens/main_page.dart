import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';
import 'package:mypt/screens/camera_testing_page.dart';
import 'pose_detector_view.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.c,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 5),
          TextButton(
            onPressed: () {
              Get.to(CameraTestingPage());
            },
            child: Text('Go to Camera Testing Page'),
          ),
          SizedBox(width: 5),
          Row(children: [ExerciseGrid(muscle: 'Chest')]),
        ],
      ),
    );
  }
}
