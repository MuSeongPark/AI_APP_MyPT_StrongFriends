import 'dart:convert';

import 'package:mypt/models/workout_result.dart';

import '../utils.dart';

import 'package:mypt/googleTTS/voice.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';
import 'workout_result.dart';

const Map<String, List<int>> jointIndx = {
  'right_hip': [12, 24, 26],
  'right_knee': [24, 26, 28]
};

class SquatAnalysis implements WorkoutAnalysis {
  final Voice speaker = Voice();
  String _state = 'up'; // up, down, none

  Map<String, List<double>> _tempAngleDict = {
    'right_hip': <double>[],
    'right_knee': <double>[],
    'avg_hip_knee': <double>[],
    'foot_length': <double>[],
    'toe_location': <double>[]
  };

  Map<String, List<int>> _feedBack = {
    'not_relaxation': <int>[],
    'not_contraction': <int>[],
    'hip_dominant': <int>[],
    'knee_dominant': <int>[],
    'not_knee_in': <int>[],
    'is_speed_fast': <int>[]
  };

  int _count = 0;
  bool _detecting = false;
  int targetCount;
  bool _end = false;

  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  get count => _count;
  get detecting => _detecting;
  get end => _end;

  SquatAnalysis({required this.targetCount});

  late int start;
  final List<String> _keys = jointIndx.keys.toList();
  final List<List<int>> _vals = jointIndx.values.toList();

  bool isStart = false;
  bool isKneeOut = false;
  late double footLength;
  late double kneeX;
  late double toeX;

  void detect(Pose pose) {
    // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    for (int i = 0; i < jointIndx.length; i++) {
      List<List<double>> listXyz = findXyz(_vals[i], landmarks);
      double angle = calculateAngle3DRight(listXyz);
      _tempAngleDict[_keys[i]]!.add(angle);
    }
    kneeX = landmarks[PoseLandmarkType.values[26]]!.x;
    toeX = landmarks[PoseLandmarkType.values[32]]!.x;

    if (_state == 'up') {
      footLength = getDistance(landmarks[PoseLandmarkType.values[32]]!,
          landmarks[PoseLandmarkType.values[30]]!);
      _tempAngleDict['foot_length']!.add(footLength);
      _tempAngleDict['toe_location']!.add(toeX);
    } else if (_tempAngleDict['foot_length']!.isEmpty &&
        _tempAngleDict['toe_location']!.isEmpty) {
      if (customSum(_tempAngleDict['foot_length']!) /
                  _tempAngleDict['foot_length']!.length *
                  0.15 +
              customSum(_tempAngleDict['toe_location']!) /
                  _tempAngleDict['toe_location']!.length <
          kneeX) {
        isKneeOut = true;
      }
    }
    double hipAngle = _tempAngleDict['right_hip']!.last;
    double kneeAngle = _tempAngleDict['right_knee']!.last;
    _tempAngleDict['avg_hip_knee']!.add((hipAngle + kneeAngle) / 2);

    if (!isStart &&
        hipAngle > 160 &&
        hipAngle < 205 &&
        kneeAngle > 160 &&
        kneeAngle < 205) {
      isStart = true;
    }

    if (!isStart) {
      int indx = _tempAngleDict['right_hip']!.length - 1;
      _tempAngleDict['right_hip']!.removeAt(indx);
      _tempAngleDict['right_knee']!.removeAt(indx);
      _tempAngleDict['avg_hip_knee']!.removeAt(indx);
    } else {
      if (isOutlierSquats(_tempAngleDict['right_hip']!, 0) ||
          isOutlierSquats(_tempAngleDict['right_knee']!, 1)) {
        int indx = _tempAngleDict['right_hip']!.length - 1;
        _tempAngleDict['right_hip']!.removeAt(indx);
        _tempAngleDict['right_knee']!.removeAt(indx);
        _tempAngleDict['avg_hip_knee']!.removeAt(indx);
      } else {
        bool isHipUp = hipAngle < 215;
        bool isHipDown = hipAngle > 240;
        bool isKneeUp = kneeAngle > 147.5;

        if (isHipUp && isKneeUp && _state == 'down') {
          //개수 카운팅
          ++_count;
          speaker.countingVoice(_count);
          speaker.stopState();
          int end = DateTime.now().second;
          _state = 'up';

          if (listMin(_tempAngleDict['right_hip']!) < 205) {
            //엉덩이를 완전히 이완
            _feedBack['not_relaxation']!.add(0);
          } else {
            //엉덩이 덜 이완
            _feedBack['not_relaxation']!.add(1);
          }
          if (listMax(_tempAngleDict['right_hip']!) > 270) {
            //엉덩이가 완전히 내려간 경우
            _feedBack['not_contraction']!.add(0);
          } else {
            //엉덩이가 덜 내려간 경우
            _feedBack['not_contraction']!.add(1);
          }
          if (listMax(_tempAngleDict['avg_hip_knee']!) > 205) {
            //엉덩이가 먼저 내려간 경우
            _feedBack['hip_dominant']!.add(1);
            _feedBack['knee_dominant']!.add(0);
          } else if (listMin(_tempAngleDict['avg_hip_knee']!) < 165) {
            //무릎이 먼저 내려간 경우
            _feedBack['hip_dominant']!.add(0);
            _feedBack['knee_dominant']!.add(1);
          } else {
            //무릎과 엉덩이가 균형있게 내려간 경우
            _feedBack['hip_dominant']!.add(0);
            _feedBack['knee_dominant']!.add(0);
            ;
          }
          if (isKneeOut) {
            //무릎이 발 밖으로 나간 경우
            _feedBack['not_knee_in']!.add(1);
          } else {
            //무릎이 발 안쪽에 있는 경우
            _feedBack['not_knee_in']!.add(0);
          }
          if ((end - start) < 1) {
            _feedBack['is_speed_fast']!.add(1);
          } else {
            _feedBack['is_speed_fast']!.add(0);
          }

          if (_feedBack['not_contraction']!.last == 0) {
            //엉덩이가 완전히 내려간 경우
            if (_feedBack['not_relaxation']!.last == 0) {
              //엉덩이를 완전히 이완
              if (_feedBack['not_knee_in']!.last == 1) {
                //무릎이 발 밖으로 나간 경우
                speaker.sayKneeOut();
              } else {
                //무릎이 발 안쪽에 있는 경우
                if (_feedBack['hip_dominant']!.last == 1) {
                  //엉덩이가 먼저 내려간 경우
                  speaker.sayHipKnee();
                } else if (_feedBack['knee_dominant']!.last == 1) {
                  //무릎이 먼저 내려간 경우
                  speaker.sayHipKnee();
                } else {
                  //무릎과 엉덩이가 균형있게 내려간 경우
                  if (_feedBack['is_speed_fast']!.last == 1) {
                    //속도가 빠른 경우
                    speaker.sayFast();
                  } else {
                    //속도가 적당한 경우
                    speaker.sayGood1();
                  }
                }
              }
            } else {
              //엉덩이 덜 이완
              speaker.sayStretchKnee();
            }
          } else {
            //엉덩이가 덜 내려간 경우
            speaker.sayHipDown();
          }

          //초기화
          _tempAngleDict['right_hip'] = <double>[];
          _tempAngleDict['right_knee'] = <double>[];
          _tempAngleDict['avg_hip_knee'] = <double>[];
          _tempAngleDict['foot_length'] = <double>[];
          _tempAngleDict['toe_location'] = <double>[];

          isKneeOut = false;

          if (_count == targetCount) {
            stopAnalysing();
          }
        } else if (isHipDown && !isKneeUp && _state == 'up') {
          _state = 'down';
          start = DateTime.now().second;
        }
      }
    }
  }

  List<int> workoutToScore() {
    List<int> score = [];
    int n = _feedBack.values.length;
    for (int i = 0; i < n; i++) {
      //_e는 pushups에 담겨있는 각각의 element
      int isRelaxation = 1 - _feedBack['not_relaxation']![i];
      int isContraction = 1 - _feedBack['not_contraction']![i];
      int isHipKneeGood = (_feedBack['hip_dominant']![i] == 0 &&
              _feedBack['knee_dominant']![i] == 0)
          ? 1
          : 0;
      int isKneeIn = 1 - _feedBack['not_knee_in']![i];
      int isSpeedgood = 1 - _feedBack['is_speed_fast']![i];
      score.add(isRelaxation * 10 +
          isContraction * 20 +
          isHipKneeGood * 50 +
          isKneeIn * 13 +
          isSpeedgood * 7);
    }
    return score;
  }

  @override
  void startDetecting() {
    _detecting = true;
  }

  void stopDetecting() {
    _detecting = false;
  }

  void stopAnalysing() {
    _end = true;
  }

  Future<void> stopAnalysingDelayed() async {
    stopDetecting();
    await Future.delayed(const Duration(seconds: 2), () {
      stopAnalysing();
    });
  }

  Future<WorkoutResult> makeWorkoutResult() async {
    List<String> feedbackNames = <String>[];  // key values of _feedback
    List<int> feedbackCounts = <int>[];       // sum of feedback which value is 1
    for (String key in _feedBack.keys.toList()) {
      feedbackNames.add(key);
      int tmp = 0;
      for (int i = 0; i < _count; i++) {
        tmp += _feedBack[key]![i];
      }
      feedbackCounts.add(tmp);
    }
    WorkoutResult workoutResult = WorkoutResult(
        user: '', // firebase로 구현
        id: 0, // firebase로 구현
        workoutName: 'squat',
        count: _count,
        score: workoutToScore(),
        workoutFeedback: WorkoutFeedback(
            feedbackNames: feedbackNames, feedbackCounts: feedbackCounts));
    print(jsonEncode(workoutResult));
    return workoutResult;
  }

  void saveWorkoutResult() async {
    WorkoutResult workoutResult = await makeWorkoutResult();
    String json = jsonEncode(workoutResult);
    // firebase로 workoutResult 서버로 보내기 구현

    // JsonStore jsonStore = JsonStore();
    // // store json 
    // await jsonStore.setItem(
    //   'workout_result_${workoutResult.id}',
    //   workoutResult.toJson()
    // );
    // // increment analysis counter value
    // Map<String, dynamic>? jsonCounter = await jsonStore.getItem('analysis_counter');
    // AnalysisCounter analysisCounter = jsonCounter != null ? AnalysisCounter.fromJson(jsonCounter) : AnalysisCounter(value: 0);
    // analysisCounter.value++;
    // await jsonStore.setItem(
    //   'analysis_counter',
    //   analysisCounter.toJson()
    // );
  }
}
