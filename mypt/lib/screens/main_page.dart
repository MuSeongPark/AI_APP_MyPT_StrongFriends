import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';
import 'package:mypt/screens/camera_testing_page.dart';
import 'package:mypt/screens/pullup_description_page.dart';
import 'package:mypt/screens/pushup_description_page.dart';
import 'package:mypt/screens/squat_description_page.dart';
import 'package:mypt/theme.dart';
import 'pose_detector_view.dart';

class MainPage extends StatelessWidget {
  @override
  Map<String, dynamic> muscleList = {
    'pushup': PushUpDescriptionPage(),
    'squat': SquatDescriptionPage(),
    'pullup': PullUpDescriptionPage(),
  };
  List<Color> colorList = [
    kPrimaryColor,
    kLightPurpleColor,
    kLightIvoryColor,
  ];

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    muscle: muscleList.keys.toList()[index],
                    backgroundColor: colorList[index % colorList.length],
                    nextPage: muscleList.values.toList()[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

          /*
          Row(
            children: [
              ExerciseGrid(muscle: 'pushup'),
              ExerciseGrid(muscle: 'squat'),
              ExerciseGrid(muscle: 'pullup')
            ],
          ),
          */
/*
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20.0,
          ),
          const Text("사용자의 신체정보",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 10.0),
          _buildBodyPic(),
          const SizedBox(height: 10.0),
          const Text("분석하고 싶은 운동",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 10.0),
          _buildCategoryList()
        ],
      ),
    );
  }

  Widget _buildBodyPic() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
            aspectRatio: 4 / 2,
            child: Image.asset(
              'human_body.jpg',
              fit: BoxFit.fitHeight,
            )));
  }

  Widget _buildCategoryList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ExerciseGrid(muscle: 'pushup'),
          ExerciseGrid(
            muscle: 'squat',
          ),
          ExerciseGrid(
            muscle: 'pullup',
          )
                  ],
      ),
    );
  }

  Widget _buildNewCategoryList(BuildContext context) {
    // 다른 모양으로 만들어보려고함
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        child: ListView.builder(
          primary: false,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ExerciseGrid(muscle: 'squat');
          },
        ));
  
  }
}
*/
