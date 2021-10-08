import '../utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

const Map<String, List<int>> jointIndx = {
  'right_elbow': [15, 13, 11],
  'right_hip': [11, 23, 25],
  'right_knee': [23, 25, 27]
};

class PushUpAnalysis implements WorkoutAnalysis {
  Map<String, List<double>> _angleDict = {
    'right_elbow': <double>[],
    'right_hip': <double>[],
    'right_knee': <double>[]
  };

  Map<String, List<double>> _tempAngleDict = {
    'right_elbow': <double>[],
    'right_hip': <double>[],
    'right_knee': <double>[]
  };

  Map<String, List<int>> _feedBack = {
    'is_elbow_up': <int>[],
    'is_elbow_down': <int>[],
    'hip_condition': <int>[],
    'knee_conditon': <int>[],
    'speed': <int>[]
  };

  final List<String> _keys = jointIndx.keys.toList();
  final List<List<int>> _vals = jointIndx.values.toList();
  String _state = 'up'; // up, down, none
  int _count = 0;
  int get count => _count;
  late int start;

  void detect(Pose pose) {
    // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    //포즈 추정한 관절값들을 가져오는 메서드
    try {
      for (int i = 0; i < jointIndx.length; i++) {
        List<List<double>> listXyz = findXyz(_vals[i], landmarks);
        double angle = calculateAngle3DRight(listXyz);
        _tempAngleDict[_keys[i]]!.add(angle);
      }
      double elbowAngle = _tempAngleDict['right_elbow']!.last;
      bool isElbowUp = (elbowAngle > 137.5);
      bool isElbowDown = (elbowAngle < 127.5);

      double hipAngle = _tempAngleDict['right_hip']!.last;
      bool hipCondition = (hipAngle > 150) && (hipAngle < 220);

      double kneeAngle = _tempAngleDict['right_knee']!.last;
      bool kneeCondition = (kneeAngle > 152) && (kneeAngle < 200);
      bool lowerBodyConditon = (hipCondition && kneeCondition);

      if (isElbowUp && (_state == 'down') && lowerBodyConditon) {
        int end = DateTime.now().second;

        _state = 'up';
        _count += 1;

        if (listMax(_tempAngleDict['right_elbow']!) > 160) {
          _feedBack['is_elbow_up']!.add(1);
        } else {
          _feedBack['is_elbow_up']!.add(0);
        }

        if (listMin(_tempAngleDict['right_elbow']!) < 90) {
          _feedBack['is_elbow_down']!.add(1);
        } else {
          _feedBack['is_elbow_down']!.add(0);
        }

        //푸쉬업 하나당 골반 판단
        if (listMin(_tempAngleDict['right_hip']!) < 160) {
          _feedBack['hip_condition']!.add(1);
        } else if (listMax(_tempAngleDict['right_hip']!) > 220) {
          _feedBack['hip_condition']!.add(2);
        } else {
          _feedBack['hip_condition']!.add(0);
        }

        //knee conditon
        if (listMin(_tempAngleDict['right_knee']!) < 152) {
          _feedBack['knee_condition']!.add(0);
        } else {
          _feedBack['knee_condition']!.add(1);
        }

        //speed
        if ((end - start) < 1) {
          _feedBack['speed']!.add(0);
        } else {
          _feedBack['speed']!.add(1);
        }

        //초기화
        _tempAngleDict['right_elbow'] = <double>[];
        _tempAngleDict['right_hip'] = <double>[];
        _tempAngleDict['right_knee'] = <double>[];
      } else if (isElbowDown && (_state == 'up') && lowerBodyConditon) {
        _state = 'down';
        start = DateTime.now().second;
      }
    } catch (e) {
      print("detect function에서 에러가 발생 : $e");
    }
  }

  List<int> workoutToScore() {
    List<int> score = [];
    int n = _feedBack.values.length;
    for (int i = 0; i < n; i++) {
      //_e는 pushups에 담겨있는 각각의 element

      int isElbowUp = _feedBack['is_elbow_up']![i];
      int isElbowDown = _feedBack['is_elbow_down']![i];
      int isHipGood = (_feedBack['hip_condition']![i] == 0) ? 1 : 0;
      int isKneeGood = _feedBack['knee_condition']![i];
      int isSpeedGood = _feedBack['speed']![i];
      score.add(isElbowUp * 25 +
          isElbowDown * 30 +
          isHipGood * 30 +
          isKneeGood * 8 +
          isSpeedGood * 7);
    }
    return score;
  }
}
