import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';
import 'package:mypt/screens/camera_testing_page.dart';
import 'package:mypt/theme.dart';
import 'pose_detector_view.dart';

class MainPage extends StatelessWidget {
  @override
  List<String> muscleList = ['pushup', 'squat', 'pullup'];
  List<Color> colorList = [
    kPrimaryColor,
    kLightPurpleColor,
    kLightIvoryColor,
  ];

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.c,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          TextButton(
            onPressed: () {
              Get.to(CameraTestingPage());
            },
            child: Text('Go to Camera Testing Page'),
          ),
          const SizedBox(width: 5),
          SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                muscleList.length,
                (index) => Container(
                  margin: EdgeInsets.all(15),
                  child: ExerciseGrid(
                    muscle: muscleList[index],
                    backgroundColor: colorList[index % colorList.length],
                  ),
                ),
              ),
            ),
          ),
          /*
          Row(
            children: [
              ExerciseGrid(muscle: 'pushup'),
              ExerciseGrid(muscle: 'squat'),
              ExerciseGrid(muscle: 'pullup')
            ],
          ),
          */
        ],
      ),
    );
  }
}
