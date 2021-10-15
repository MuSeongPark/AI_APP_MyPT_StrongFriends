import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/exercise_grid.dart';
import 'package:mypt/data/muscle_list.dart';
import 'package:mypt/screens/analysis/analysis_page.dart';
import 'package:mypt/screens/analysis/bar_chart_page.dart';
import 'package:mypt/screens/camera_testing_page.dart';
import 'package:mypt/screens/workout_description_page.dart';
import 'package:mypt/theme.dart';
import 'pose_detector_view.dart';

List<Color> colorList = [
  kPrimaryColor,
  kLightPurpleColor,
  kLightIvoryColor,
];

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: const [
                Align(
                  alignment: Alignment(-0.75, 0),
                  child: FittedBox(
                    child: Text(
                      '자신에게 적합한 운동을 찾아보세요!',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.75, 0),
                  child: FittedBox(
                    child: Text(
                      '완벽한 자세로 운동할 수 있습니다!',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(BarChartPage());
              //Get.to(AnalysisPage('chest'));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width * 0.75,
                child: Stack(
                  children: [
                    Positioned(
                      left: 15,
                      top: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            '당신의 운동을',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' 분석 해보세요!',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        height: mediaQuery.size.height * 0.2,
                        width: mediaQuery.size.width * 0.3,
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset('images/magnifying_glass.png'),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 7.0) // changes position of shadow
                        ),
                  ],
                ),
              ),
            ),
          ),
          /*
          빠르게 카메라 확인하고 싶을때 주석 해체하시면 됩니다. 
          TextButton(
            onPressed: () {
              Get.to(CameraTestingPage());
            },
            child: const Text('Go to Camera Testing Page'),
          ),
          */
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(
                        bottom: 15,
                        left: 10,
                        right: 10,
                      ),
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
        ],
      ),
    );
  }
}
