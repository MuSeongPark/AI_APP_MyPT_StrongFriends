import 'package:flutter/material.dart';
import 'package:mypt/googleTTS/voice.dart';
import '../utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

const Map<String, List<int>> jointIndx = {
  'right_elbow': [15, 13, 11],
  'right_hip': [11, 23, 25],
  'right_knee': [23, 25, 27]
};
//음성
final Voice speaker = Voice();

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
    'knee_condition': <int>[],
    'speed': <int>[]
  };
  bool isStart = false;

  final List<String> _keys = jointIndx.keys.toList();
  final List<List<int>> _vals = jointIndx.values.toList();
  String _state = 'up'; // up, down, none
  int _count = 0;
  int get count => _count;
  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  late int start;

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
      if (!isStart){
        bool isPushUpAngle = elbowAngle > 140 && elbowAngle < 190 && hipAngle > 140 && hipAngle < 190 && kneeAngle > 125 && kneeAngle < 180;
        if (isPushUpAngle){
          isStart = true;
        }
      }
      if (!isStart){
        int indx = _tempAngleDict['right_elbow']!.length - 1;
        _tempAngleDict['right_elbow']!.removeAt(indx);
        _tempAngleDict['right_hip']!.removeAt(indx);
        _tempAngleDict['right_knee']!.removeAt(indx);

      } else{

        if (isOutlierPushUps(_tempAngleDict['right_elbow']!, 0) || isOutlierPushUps(_tempAngleDict['right_hip']!, 1) || isOutlierPushUps(_tempAngleDict['right_knee']!, 2)){
          int indx = _tempAngleDict['right_elbow']!.length - 1;
          _tempAngleDict['right_elbow']!.removeAt(indx);
          _tempAngleDict['right_hip']!.removeAt(indx);
          _tempAngleDict['right_knee']!.removeAt(indx);
        } else {
          if (isElbowUp && (_state == 'down') && lowerBodyConditon) {
            int end = DateTime.now().second;
            _state = 'up';
            _count += 1;

            if (listMax(_tempAngleDict['right_elbow']!) > 160) {
              //팔꿈치를 완전히 핀 경우
              _feedBack['is_elbow_up']!.add(1);
            } else {
              //팔꿈치를 덜 핀 경우
              _feedBack['is_elbow_up']!.add(0);
            }

            if (listMin(_tempAngleDict['right_elbow']!) < 70) {
              //팔꿈치를 완전히 굽힌 경우
              _feedBack['is_elbow_down']!.add(1);
            } else {
              //팔꿈치를 덜 굽힌 경우
              _feedBack['is_elbow_down']!.add(0);
            }

            //푸쉬업 하나당 골반 판단
            if (listMin(_tempAngleDict['right_hip']!) < 152) {
              //골반이 내려간 경우
              _feedBack['hip_condition']!.add(1);
            } else if (listMax(_tempAngleDict['right_hip']!) > 250) {
              //골반이 올라간 경우
              _feedBack['hip_condition']!.add(2);
            } else {
              //정상
              _feedBack['hip_condition']!.add(0);
            }

            //knee conditon
            if (listMin(_tempAngleDict['right_knee']!) < 130) {
              //무릎이 내려간 경우
              _feedBack['knee_condition']!.add(0);
            } else {
              //무릎이 정상인 경우
              _feedBack['knee_condition']!.add(1);
            }

            //speed
            if ((end - start) < 1) {
              //속도가 빠른 경우
              _feedBack['speed']!.add(0);
            } else {
              //속도가 적당한 경우
              _feedBack['speed']!.add(1);
            }


            if (_feedBack['is_elbow_down']!.last == 1) {
              //팔꿈치를 완전히 굽힌 경우
              if (_feedBack['is_elbow_up']!.last == 1) {
                //팔꿈치를 완전히 핀 경우
                if (_feedBack['hip_condition']!.last == 1) {
                  //골반이 내려간 경우
                  speaker.sayHipUp();

                } else if (_feedBack['hip_condition']!.last == 2) {
                  //골반이 올라간 경우
                  speaker.sayHipDown();

                } else {
                  //정상
                  if (_feedBack['knee_condition']!.last == 0) {
                    //무릎이 내려간 경우
                    speaker.sayKneeUp();

                  } else {
                    //무릎이 정상인 경우
                    if (feedBack['speed']!.last == 0) {
                      //속도가 빠른 경우
                      speaker.sayFast();

                    } else {
                      //속도가 적당한 경우
                      speaker.sayGood1();
                    }
                  }
                }
              } else {
                //팔꿈치를 덜 핀 경우
                speaker.sayStretchElbow();
              } 
            } else {
              //팔꿈치를 덜 굽힌 경우
              speaker.sayBendElbow();
            }
            
            //초기화
            _tempAngleDict['right_elbow'] = <double>[];
            _tempAngleDict['right_hip'] = <double>[];
            _tempAngleDict['right_knee'] = <double>[];
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
