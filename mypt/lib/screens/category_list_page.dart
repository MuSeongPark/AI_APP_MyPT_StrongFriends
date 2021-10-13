import 'package:flutter/material.dart';
import 'package:mypt/data/muscle_list.dart';
import 'package:mypt/models/workout_analysis.dart';
import 'package:mypt/screens/analysis/analysis_page.dart';
import 'package:mypt/screens/exercise_listview.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:mypt/components/record_grid.dart';
import 'package:mypt/screens/workout_description_page.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/screens/analysis/result_page.dart';

class CategoryListPage extends StatelessWidget {
  CategoryListPage({Key? key}) : super(key: key);
  List<WorkoutResult> workoutResultList = 
  <WorkoutResult>[WorkoutResult(
    user: 'mingu', workoutName: 'Squat', count: 10, 
    score: [100, 80, 200], 
    workoutFeedback: WorkoutFeedback(feedbackCounts: [1, 2], 
    feedbackNames: ['not_contraction', 'not_relaxation'],
    ))];

  @override
  Widget build(BuildContext context) {
    return _buildAnalysisList();
  }

  Widget _buildAnalysisList(){
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        3, 
        (index) => Container(
          margin: const EdgeInsets.all(12),
          child: RecordGrid(
            muscle: muscleList.keys.toList()[index],
            backgroundColor: colorList[index % colorList.length],
            //nextPage: WorkoutDescriptionPage(workoutName: muscleList.keys.toList()[index]),
            // 일단은 주석처리 해놓음. Chest, Legs, Abs 등 부위별로 분리할 시 아래 코드 응용하면 됌
            nextPage: ResultPage(workoutResult: workoutResultList[0])
          ),
        ),
      ),
    );
  }
}
