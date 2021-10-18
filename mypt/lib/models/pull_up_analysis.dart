import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'dart:convert';

import 'package:mypt/googleTTS/voice.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';
import 'workout_result.dart';
import 'package:mypt/utils.dart';

const Map<String, List<int>> jointIndx = {
  'right_elbow': [16, 14, 12],
  'right_shoulder': [14, 12, 24],
  'right_hip': [12, 24, 26],
};

class PullUpAnalysis implements WorkoutAnalysis {
  final Voice speaker = Voice();
  String _state = 'down'; // up, down, none

  Map<String, List<double>> _tempAngleDict = {
    'right_elbow': <double>[],
    'right_shoulder': <double>[],
    'right_hip': <double>[],
    'elbow_normY': <double>[],
  };

  Map<String, List<int>> _feedBack = {
    'not_relaxation': <int>[],
    'not_contraction': <int>[],
    'not_elbow_stable': <int>[],
    'is_recoil': <int>[],
    'is_speed_fast': <int>[],
  };

  int _count = 0;
  bool _detecting = false;
  int targetCount;
  bool _end = false;

  get count => _count;
  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  get detecting => _detecting;
  get end => _end;
  get state => _state;

  PullUpAnalysis({required this.targetCount});

  late int start;
  List<String> _keys = jointIndx.keys.toList();
  List<List<int>> _vals = jointIndx.values.toList();

  bool isStart = false;
  bool isTotallyContraction = false;
  bool wasTotallyContraction = false;

  void detect(Pose pose) {
    // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    for (int i = 0; i < jointIndx.length; i++) {
      List<List<double>> listXyz = findXyz(_vals[i], landmarks);
      double angle = calculateAngle2D(listXyz, direction: 1);

      if ((_keys[i] == 'right_shoulder') && (angle < 190)) {
        angle = 360 - angle;
      } else if ((_keys[i] == 'right_elbow') &&
          (angle > 190) &&
          (angle < 360)) {
        angle = 360 - angle;
      }
      _tempAngleDict[_keys[i]]!.add(angle);
    }
    List<double> arm = [
      landmarks[PoseLandmarkType.values[14]]!.x -
          landmarks[PoseLandmarkType.values[16]]!.x,
      landmarks[PoseLandmarkType.values[14]]!.y -
          landmarks[PoseLandmarkType.values[16]]!.y
    ];

    List<double> normY = [0, 1];
    double normY_angle = calculateAngle2DVector(arm, normY);
    if (normY_angle >= 90) {
      normY_angle = 10;
    }
    _tempAngleDict['elbow_normY']!.add(normY_angle);

    double elbowAngle = _tempAngleDict['right_elbow']!.last;
    double shoulderAngle = _tempAngleDict['right_shoulder']!.last;
    double hipAngle = _tempAngleDict['right_hip']!.last;
    if (!isStart &&
        _detecting &&
        shoulderAngle > 190 &&
        shoulderAngle < 220 &&
        elbowAngle > 140 &&
        elbowAngle < 180 &&
        normY_angle < 15 &&
        hipAngle > 120 &&
        hipAngle < 200) {
      speaker.sayStart();
      isStart = true;
    }
    if (!isStart) {
      _tempAngleDict['right_elbow']!.removeLast();
      _tempAngleDict['right_shoulder']!.removeLast();
      _tempAngleDict['right_hip']!.removeLast();
      _tempAngleDict['elbow_normY']!.removeLast();
    } else {
      if (isOutlierPullUps(_tempAngleDict['right_elbow']!, 0) ||
          isOutlierPullUps(_tempAngleDict['right_shoulder']!, 1) ||
          isOutlierPullUps(_tempAngleDict['right_hip']!, 2)) {
        
        _tempAngleDict['right_elbow']!.removeLast();
        _tempAngleDict['right_shoulder']!.removeLast();
        _tempAngleDict['right_hip']!.removeLast();
        _tempAngleDict['elbow_normY']!.removeLast();
      } else {
        bool isElbowUp = elbowAngle < 97.5;
        bool isElbowDown = elbowAngle > 110 && elbowAngle < 180;
        bool isShoulderUp = shoulderAngle > 268 && shoulderAngle < 360;
        double rightMouthY = landmarks[PoseLandmarkType.values[10]]!.y;
        double rightElbowY = landmarks[PoseLandmarkType.values[14]]!.y;
        double rightWristY = landmarks[PoseLandmarkType.values[16]]!.y;

        bool isMouthUpperThanElbow = rightMouthY < rightElbowY;
        bool isMouthUpperThanWrist = rightMouthY < rightWristY;
        //완전 수축 정의
        if (!isTotallyContraction &&
            isMouthUpperThanWrist &&
            elbowAngle < 100 &&
            shoulderAngle > 280) {
          isTotallyContraction = true;
        } else if (elbowAngle > 76 && !isMouthUpperThanWrist) {
          isTotallyContraction = false;
          wasTotallyContraction = true;
        }

        if (isElbowDown &&
            !isShoulderUp &&
            _state == 'up' &&
            !isMouthUpperThanElbow) {
          //개수 카운팅
          ++_count;
          speaker.countingVoice(_count);
          //speaker.stopState();

          int end = DateTime.now().second;
          _state = 'down';
          //IsRelaxation !
          if (listMax(_tempAngleDict['right_elbow']!) > 145 &&
              listMin(_tempAngleDict['right_shoulder']!) < 250) {
            //완전히 이완한 경우
            _feedBack['not_relaxation']!.add(0);
          } else {
            //덜 이완한 경우(팔을 덜 편 경우)
            _feedBack['not_relaxation']!.add(1);
          }
          //IsContraction
          if (wasTotallyContraction) {
            //완전히 수축
            _feedBack['not_contraction']!.add(0);
          } else {
            //덜 수축된 경우
            _feedBack['not_contraction']!.add(1);
          }

          //IsElbowStable
          if (listMax(_tempAngleDict['elbow_normY']!) < 40) {
            //팔꿈치를 고정한 경우
            _feedBack['not_elbow_stable']!.add(0);
          } else {
            //팔꿈치를 고정하지 않은 경우
            _feedBack['not_elbow_stable']!.add(1);
          }

          //is_recoil
          if (listMax(_tempAngleDict['right_elbow']!) > 260 &&
              listMax(_tempAngleDict['right_elbow']!) < 330) {
            // 반동을 사용햇던 경우
            _feedBack['is_recoil']!.add(1);
          } else {
            // 반동을 사용하지 않은 경우
            _feedBack['is_recoil']!.add(0);
          }

          //IsSpeedGood
          if ((end - start) < 1.5) {
            //속도가 빠른 경우
            _feedBack['is_speed_fast']!.add(1);
          } else {
            //속도가 적당한 경우
            _feedBack['is_speed_fast']!.add(0);
          }

          wasTotallyContraction = false;
          isTotallyContraction = false;


          if (_feedBack['is_recoil']!.last == 0) {
            //반동을 사용하지 않은 경우
            if (_feedBack['not_elbow_stable']!.last == 0) {
              //팔꿈치를 고정한 경우
              if (_feedBack['not_contraction']!.last == 0) {
                // 완전히 수축
                if (_feedBack['not_relaxation']!.last == 0) {
                  // 완전히 이완한 경우
                  if (_feedBack['is_speed_fast']!.last == 0) {
                    //속도가 적당한 경우
                    speaker.sayGood2(_count);
                  } else {
                    // 덜 이완한 경우(팔을 덜 편 경우)
                    speaker.sayStretchElbow(_count);
                    //속도가 빠른 경우
                    speaker.sayFast(_count);
                  }
                } else {
                  // 덜 이완한 경우(팔을 덜 편 경우)
                  speaker.sayStretchElbow(_count);
                }
              } else {
                // 덜 수축된 경우
                speaker.sayUp(_count);
              }
            } else {
              //팔꿈치를 고정하지 않은 경우
              speaker.sayElbowFixed(_count);
            }
          } else {
            // 반동을 사용한경우
            speaker.sayDontUseRecoil(_count);
          }

          _tempAngleDict['right_hip'] = <double>[];
          _tempAngleDict['right_knee'] = <double>[];
          _tempAngleDict['right_elbow'] = <double>[];
          _tempAngleDict['elbow_normY'] = <double>[];

          if (_count == targetCount) {
            stopAnalysing();
          }
        } else if (isElbowUp &&
            isShoulderUp &&
            _state == 'down' &&
            isMouthUpperThanElbow) {
          _state = 'up';
          start = DateTime.now().second;
        }
      }
    }
  }

  List<int> workoutToScore() {
    List<int> score = [];
    int n = _count;
    for (int i = 0; i < n; i++) {
      //_e는 pullups에 담겨있는 각각의 element

      int isRelaxation = 1 - _feedBack['not_relaxation']![i];
      int isContraction = 1 - _feedBack['not_contraction']![i];
      int isElbowStable = 1 - _feedBack['not_elbow_stable']![i];
      int isNotRecoil = 1 - _feedBack['is_recoil']![i];
      int isSpeedGood = 1 - _feedBack['is_speed_fast']![i];
      score.add(isRelaxation * 15 +
          isContraction * 40 +
          isElbowStable * 20 +
          isNotRecoil * 15 +
          isSpeedGood * 10);
    }
    return score;
  }

  @override
  void startDetecting() {
    _detecting = true;
  }

  Future<void> startDetectingDelayed() async {
    speaker.sayStartDelayed();
    await Future.delayed(const Duration(seconds: 8), () {
      startDetecting();
    });
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
    CollectionReference user_file =
        FirebaseFirestore.instance.collection('user_file');
    String user_uid = user_file.id;
    List<int> feedbackCounts = <int>[]; // sum of feedback which value is 1
    for (String key in _feedBack.keys.toList()) {
      int tmp = 0;
      for (int i = 0; i < _count; i++) {
        tmp += _feedBack[key]![i];
      }
      feedbackCounts.add(tmp);
    }
    WorkoutResult workoutResult = WorkoutResult(
        user: '', // firebase로 구현
        uid: '$user_uid', // firebase로 구현
        workoutName: 'pull_up',
        count: _count,
        score: workoutToScore(),
        feedbackCounts: feedbackCounts);
    print(jsonEncode(workoutResult));
    return workoutResult;
  }

  void saveWorkoutResult() async {
    WorkoutResult workoutResult = makeWorkoutResult();
    String json = jsonEncode(workoutResult);

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    CollectionReference exerciseDB =
        FirebaseFirestore.instance.collection('exercise_DB');

    Future<void> exercisestart() {
      // Call the user's CollectionReference to add a new user
      print("streamstart");
      return exerciseDB
          .doc()
          .set(workoutResult.toJson())
          .then((value) => print("json added"))
          .catchError((error) => print("Failed to add json: $error"));
    }

    exercisestart();
    print("streamend");
  }
}
