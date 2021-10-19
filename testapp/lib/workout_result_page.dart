import 'package:flutter/material.dart';
import 'package:testapp/customized_bar_chart.dart';
import 'package:testapp/build_no_title_appbar.dart';
import 'package:testapp/workout_result.dart';
import 'package:testapp/utils.dart';

class WorkoutResultPage extends StatelessWidget {
  WorkoutResultPage({Key? key, required this.workoutResult}) : super(key: key);
  WorkoutResult workoutResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "개수: ${workoutResult.count}      점수: ${sumInt(workoutResult.score!)}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Container(
                height: 360,
                width: 360,
                child: CustomizedBarChart(
                  workoutResult: workoutResult,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color(0xffFFE6D6),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: _buildFeedback(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    List<int> feedbackIdx = sortFeedback(workoutResult.feedbackCounts!);
    List<String> feedbackString;
    if (workoutResult.workoutName! == 'push_up') {
      feedbackString = PushUpFeedbackString;
    } else if (workoutResult.workoutName! == 'pull_up') {
      feedbackString = PullUpFeedbackString;
    } else {
      // squat
      feedbackString = SquatFeedbackString;
    }
    String feedbackResult = "";
    int num = 2;
    for (int i in feedbackIdx) {
      if (num == 0) break;
      feedbackResult += feedbackString[i] + '\n';
      num--;
    }
    return Text(
      feedbackResult,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

List<String> SquatFeedbackString = [
  '''이완을 더 해주세요. 이완을 통해 근섬유의 길이가 더 길어지며, 비대해질 수 있습니다.''',
  '''수축을 더 해주세요. 수축을 제대로 하지 않으면 운동효과를 기대하기 어렵습니다.''',
  '''엉덩이가 무릎보다 먼저 수축하고 있습니다. 무릎과 엉덩이가 동시에 수축해야 근육이 균등하게 발달할수 있습니다.''',
  '''무릎이 엉덩이보다 먼저 수축하고 있습니다. 무릎과 엉덩이가 동시에 수축해야 근육이 균등하게 발달할수 있습니다.''',
  '''무릎이 발끝보다 앞으로 나가고 있습니다. 무릎이 많이 나오면 무릎관절에 무리가 갈 수 있습니다.''',
  '''너무 빠른속도로 운동하고 있습니다. 자세에 신경쓰고 근육의 이완과 수축을 느끼며 운동해보세요.'''
];

List<String> PullUpFeedbackString = [
  '''이완을 더 해주세요. 이완을 통해 근섬유의 길이가 더 길어지며, 비대해질 수 있습니다.''',
  '''수축을 더 해주세요. 수축을 제대로 하지 않으면 운동효과를 기대하기 어렵습니다.''',
  '''운동을 하면서 팔이 흔들리고 있습니다. 전완근을 사용해서 운동하는 것이 아닌 등에 초점을 맞춰주세요.''',
  '''반동을 사용해 운동하고 있습니다. 운동효과가 떨어질 수 있어요. 만약 힘에 부친다면 밴드를 발에 걸어 운동해보세요.''',
  '''너무 빠른속도로 운동하고 있습니다. 자세에 신경쓰고 근육의 이완과 수축을 느끼며 운동해보세요.'''
];

List<String> PushUpFeedbackString = [
  '''이완을 더 해주세요. 이완을 통해 근섬유의 길이가 더 길어지며, 비대해질 수 있습니다.''',
  '''수축을 더 해주세요. 수축을 제대로 하지 않으면 운동효과를 기대하기 어렵습니다.''',
  '''골반이 올라간 상태로 운동하고 있습니다. 어깨, 팔꿈치 손목에 부상을 당할 수 있는 자세이면서 운동효과가 떨어질 수 있어요.''',
  '''골반이 내려간 상태로 운동하고 있습니다. 하중이 내려간 자세라서 횟수를 쉽게 늘릴 수 있지만, 올바른 운동효과를 기대하기 어려워요.''',
  '''무릎이 접힌 상태로 운동하고 있습니다. 하중이 내려간 자세라서 횟수를 쉽게 늘릴 수 있지만, 올바른 운동효과를 기대하기 어려워요.''',
  '''너무 빠른속도로 운동하고 있습니다. 자세에 신경쓰고 근육의 이완과 수축을 느끼며 운동해보세요.'''
];
