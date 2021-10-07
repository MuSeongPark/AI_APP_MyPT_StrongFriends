import '../utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

const Map<String, List<int>> jointIndx = {
  'left_elbow': [15, 13, 11],
  'left_hip': [11, 23, 25],
  'left_knee': [23, 25, 27]
};

class PushUpAnalysis extends WorkoutAnalysis {
  Map<String, List<double>> _angleDict = {
    'left_elbow': <double>[],
    'left_hip': <double>[],
    'left_knee': <double>[]
  };

  Map<String, List<double>> _tempAngleDict = {
    'left_elbow': <double>[],
    'left_hip': <double>[],
    'left_knee': <double>[]
  };

  Map<String, List<int>> _feedBack = {
    'Is_elbow_up': <int>[],
    'Is_elbow_down': <int>[],
    'hip_condition': <int>[]
  };

  final List<String> _keys = jointIndx.keys.toList();
  final List<List<int>> _vals = jointIndx.values.toList();
  String _state = 'up'; // up, down, none
  int _count = 0;
  int get count => _count;

  void detect(Pose pose) {
    // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    //포즈 추정한 관절값들을 가져오는 메서드
    for (int i = 0; i < jointIndx.length; i++) {
      List<List<double>> listXyz = findXyz(_vals[i], landmarks);
      double angle = calculateAngle3DLeft(listXyz);
      _angleDict[_keys[i]]!.add(angle);
      _tempAngleDict[_keys[i]]!.add(angle);
    }
    double elbowAngle = _tempAngleDict['left_elbow']!.last;
    if ((elbowAngle > 135) & (_state == 'down')) {
      _state = 'up';
      _count += 1;

      if (listMax(_tempAngleDict['left_elbow']!) > 160) {
        _feedBack['Is_elbow_up']!.add(1);
      } else {
        _feedBack['Is_elbow_up']!.add(0);
      }

      if (listMin(_tempAngleDict['left_elbow']!) < 90) {
        _feedBack['Is_elbow_down']!.add(1);
      } else {
        _feedBack['Is_elbow_down']!.add(0);
      }

      //푸쉬업 하나당 골반 판단
      if (listMin(_tempAngleDict['left_hip']!) < 160) {
        _feedBack['hip_condition']!.add(1);
      } else if (listMax(_tempAngleDict['left_hip']!) > 220) {
        _feedBack['hip_condition']!.add(2);
      } else {
        _feedBack['hip_condition']!.add(0);
      }

      //초기화
      _tempAngleDict['left_elbow'] = <double>[];
      _tempAngleDict['left_hip'] = <double>[];
      _tempAngleDict['left_knee'] = <double>[];
    }
    if ((elbowAngle < 130) & (_state == 'up')) {
      _state = 'down';
    }
  }
}
