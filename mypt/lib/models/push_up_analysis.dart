import 'package:flutter/material.dart';
import 'package:mypt/googleTTS/voice.dart';
import '../utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';
import 'package:mypt/models/workout_result.dart';
import 'dart:convert';

const Map<String, List<int>> jointIndx = {
  'right_elbow': [15, 13, 11],
  'right_hip': [11, 23, 25],
  'right_knee': [23, 25, 27]
};

class PushUpAnalysis implements WorkoutAnalysis {
  final Voice speaker = Voice();
  String _state = 'up'; // up, down, none

  Map<String, List<double>> _tempAngleDict = {
    'right_elbow': <double>[],
    'right_hip': <double>[],
    'right_knee': <double>[]
  };

  Map<String, List<int>> _feedBack = {
    'not_elbow_up': <int>[],
    'not_elbow_down': <int>[],
    'is_hip_up': <int>[],
    'is_hip_down': <int>[],
    'is_knee_down': <int>[],
    'is_speed_fast': <int>[]
  };

  int _count = 0;
  bool _detecting = false;
  bool _end = false;
  int targetCount;

  get count => _count;
  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  get detecting => _detecting;
  get end => _end;

  PushUpAnalysis({required this.targetCount});

  late int start;
  final List<String> _keys = jointIndx.keys.toList();
  final List<List<int>> _vals = jointIndx.values.toList();

  bool isStart = false;

  void detect(Pose pose) {
    // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    //포즈 추정한 관절값들을 가져오는 메서드
    try {
      for (int i = 0; i < jointIndx.length; i++) {
        List<List<double>> listXyz = findXyz(_vals[i], landmarks);
        double angle = calculateAngle2D(listXyz, direction: 1);

        _tempAngleDict[_keys[i]]!.add(angle);
      }
      double elbowAngle = _tempAngleDict['right_elbow']!.last;
      bool isElbowUp = (elbowAngle > 130);
      bool isElbowDown = (elbowAngle < 110);

      double hipAngle = _tempAngleDict['right_hip']!.last;
      bool hipCondition = (hipAngle > 140) && (hipAngle < 220);

      double kneeAngle = _tempAngleDict['right_knee']!.last;
      bool kneeCondition = kneeAngle > 130 && kneeAngle < 205;
      bool lowerBodyConditon = hipCondition && kneeCondition;
      if (!isStart) {
        bool isPushUpAngle = elbowAngle > 140 &&
            elbowAngle < 190 &&
            hipAngle > 140 &&
            hipAngle < 190 &&
            kneeAngle > 125 &&
            kneeAngle < 180;
        if (isPushUpAngle) {
          speaker.sayStart();
          isStart = true;
        }
      }
      if (!isStart) {
        int indx = _tempAngleDict['right_elbow']!.length - 1;
        _tempAngleDict['right_elbow']!.removeAt(indx);
        _tempAngleDict['right_hip']!.removeAt(indx);
        _tempAngleDict['right_knee']!.removeAt(indx);
      } else {
        if (isOutlierPushUps(_tempAngleDict['right_elbow']!, 0) ||
            isOutlierPushUps(_tempAngleDict['right_hip']!, 1) ||
            isOutlierPushUps(_tempAngleDict['right_knee']!, 2)) {
          int indx = _tempAngleDict['right_elbow']!.length - 1;
          _tempAngleDict['right_elbow']!.removeAt(indx);
          _tempAngleDict['right_hip']!.removeAt(indx);
          _tempAngleDict['right_knee']!.removeAt(indx);
        } else {
          if (isElbowUp && (_state == 'down') && lowerBodyConditon) {
            int end = DateTime.now().second;
            _state = 'up';
            _count += 1;
            speaker.countingVoice(_count);
            //speaker.stopState();

            if (listMax(_tempAngleDict['right_elbow']!) > 160) {
              //팔꿈치를 완전히 핀 경우
              _feedBack['not_elbow_up']!.add(0);
            } else {
              //팔꿈치를 덜 핀 경우
              _feedBack['not_elbow_up']!.add(1);
            }

            if (listMin(_tempAngleDict['right_elbow']!) < 80) {
              //팔꿈치를 완전히 굽힌 경우
              _feedBack['not_elbow_down']!.add(0);
            } else {
              //팔꿈치를 덜 굽힌 경우
              _feedBack['not_elbow_down']!.add(1);
            }

            //푸쉬업 하나당 골반 판단
            if (listMin(_tempAngleDict['right_hip']!) < 152) {
              //골반이 내려간 경우
              _feedBack['is_hip_up']!.add(0);
              _feedBack['is_hip_down']!.add(1);
            } else if (listMax(_tempAngleDict['right_hip']!) > 250) {
              //골반이 올라간 경우
              _feedBack['is_hip_up']!.add(1);
              _feedBack['is_hip_down']!.add(0);
            } else {
              //정상
              _feedBack['is_hip_up']!.add(0);
              _feedBack['is_hip_down']!.add(0);
            }

            //knee conditon
            if (listMin(_tempAngleDict['right_knee']!) < 130) {
              //무릎이 내려간 경우
              _feedBack['is_knee_down']!.add(1);
            } else {
              //무릎이 정상인 경우
              _feedBack['is_knee_down']!.add(0);
            }

            //speed
            if ((end - start) < 1) {
              //속도가 빠른 경우
              _feedBack['is_speed_fast']!.add(1);
            } else {
              //속도가 적당한 경우
              _feedBack['is_speed_fast']!.add(0);
            }

            if (_feedBack['not_elbow_down']!.last == 0) {
              //팔꿈치를 완전히 굽힌 경우
              if (_feedBack['not_elbow_up']!.last == 0) {
                //팔꿈치를 완전히 핀 경우
                if (_feedBack['is_hip_down']!.last == 1) {
                  //골반이 내려간 경우
                  speaker.sayHipUp(_count);
                } else if (_feedBack['is_hip_up']!.last == 1) {
                  //골반이 올라간 경우
                  speaker.sayHipDown(_count);
                } else {
                  //정상
                  if (_feedBack['is_knee_down']!.last == 1) {
                    //무릎이 내려간 경우
                    speaker.sayKneeUp(_count);
                  } else {
                    //무릎이 정상인 경우
                    if (feedBack['is_speed_fast']!.last == 1) {
                      //속도가 빠른 경우
                      speaker.sayFast(_count);
                    } else {
                      //속도가 적당한 경우
                      speaker.sayGood1(_count);
                    }
                  }
                }
              } else {
                //팔꿈치를 덜 핀 경우
                speaker.sayStretchElbow(_count);
              }
            } else {
              //팔꿈치를 덜 굽힌 경우
              speaker.sayBendElbow(_count);
            }

            //초기화
            _tempAngleDict['right_elbow'] = <double>[];
            _tempAngleDict['right_hip'] = <double>[];
            _tempAngleDict['right_knee'] = <double>[];

            if (_count == targetCount) {
              stopAnalysing();
            }
          } else if (isElbowDown && _state == 'up' && lowerBodyConditon) {
            _state = 'down';
            start = DateTime.now().second;
          }
        }
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

      int isElbowUp = 1 - _feedBack['not_elbow_up']![i];
      int isElbowDown = 1 - _feedBack['not_elbow_down']![i];
      int isHipGood =
          (_feedBack['is_hip_up']![i] == 0 && _feedBack['is_hip_down']![i] == 0)
              ? 1
              : 0;
      int isKneeGood = 1 - _feedBack['is_knee_down']![i];
      int isSpeedGood = 1 - _feedBack['is_speed_fast']![i];
      score.add(isElbowUp * 25 +
          isElbowDown * 30 +
          isHipGood * 30 +
          isKneeGood * 8 +
          isSpeedGood * 7);
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

  WorkoutResult makeWorkoutResult() {
    List<int> feedbackCounts = <int>[];       // sum of feedback which value is 1
    for (String key in _feedBack.keys.toList()) {
      int tmp = 0;
      for (int i = 0; i < _count; i++) {
        tmp += _feedBack[key]![i];
      }
      feedbackCounts.add(tmp);
    }
    WorkoutResult workoutResult = WorkoutResult(
        user: '', // firebase로 구현
        id: 0, // firebase로 구현
        workoutName: 'push_up',
        count: _count,
        score: workoutToScore(),
        feedbackCounts: feedbackCounts);
    print(jsonEncode(workoutResult));
    return workoutResult;
  }

  void saveWorkoutResult() async {
    WorkoutResult workoutResult = makeWorkoutResult();
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
