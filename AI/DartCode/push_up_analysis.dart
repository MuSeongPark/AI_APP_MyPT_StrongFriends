
import 'dart:math';

import '../utils.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';


List<int> pushupsToScore(List<List<int>> pushups){
  /*
  pushups : [[element1],[element2],...]
  element : [IsElbowUp, IsElbowDown, HipCondition, KneeCondition, IsSpeedGood]
  */
  List<int> score = [];
  for (List<int> _e in pushups){ //_e는 pushups에 담겨있는 각각의 element
    int IsElbowUp = _e[0];
    int IsElbowDown = _e[1];
    int IsHipGood = 0;
    if (_e[2] == 0){
      IsHipGood = 1;
    }
    int IsKneeGood = _e[3];
    int IsSpeedGood = _e[4];
    score.add(IsElbowUp*25 + IsElbowDown*30 + IsHipGood*30 + IsKneeGood*8 + IsSpeedGood*7);
  }
  return score;
}



class PushUpAnalysis extends WorkoutAnalysis{
  final Map _jointIndx = {
    'right_elbow':[16,14,12],
    'right_hip':[12,24,26],
    'right_knee':[24,26,28]
  };

  Map _tempAngleDict = {
    'right_elbow':[],
    'right_hip':[],
    'right_knee':[]
  };
  List<List<int>> _pushUps =[];

  late int start;
  late List _keys;
  late List _vals;
  late String _state; // up, down, none
  int _count = 0;
  int get count => _count;
  
  PushUpAnalysis(){
    _keys = _jointIndx.keys.toList();
    _vals = _jointIndx.values.toList();
    _state = 'up';
  }

  void detect(Pose pose){ // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
     if (landmarks != null){ //포즈 추정한 관절값들을 가져오는 메서드
      for (int i = 0; i<_jointIndx.length; i++){
        List<List<double>> listXyz = findXyz(_vals[i], landmarks);
        double angle = calculateAngle3DRight(listXyz);
        _tempAngleDict[_keys[i]].add(angle);
      }
      double elbowAngle = _tempAngleDict['right_elbow'].last;
      bool IsElbowUp = (elbowAngle > 137.5);
      bool IsElbowDown = (elbowAngle < 127.5);

      double hipAngle = _tempAngleDict['right_hip'].last;
      bool hipCondition = (hipAngle > 150) && (hipAngle < 220);

      double kneeAngle = _tempAngleDict['right_knee'].last;
      bool kneeCondition = (kneeAngle > 152) && (kneeAngle < 200);
      bool lowerBodyConditon = (hipCondition && kneeCondition);

      if ((IsElbowUp && (_state == 'down')) && lowerBodyConditon){
        int end = DateTime.now().second;

        _state = 'up';
        List<int> element = [];
        //elbow
        if (listMax(_tempAngleDict['right_elbow']) > 160){
          element.add(1);
        }else{
          element.add(0);
        }
        if (listMin(_tempAngleDict['right_elbow']) < 90){
          element.add(1);
        }else{
          element.add(0);
        }
        _tempAngleDict['right_elbow'] = [];
        //hip
        if (listMin(_tempAngleDict['right_hip']) < 160){
          element.add(1);
        }else if (listMax(_tempAngleDict['right_hip']) > 220){
          element.add(2);
        }else{
          element.add(0);
        }
        _tempAngleDict['right_hip'] = [];
        //knee condition
        if (listMin(_tempAngleDict['right_knee']) < 152){
          element.add(0);
        }else{
          element.add(1);
        }
        _tempAngleDict['right_knee'] = [];

        //speed
        if ((end-start) < 1){
          element.add(0);
        }else{
          element.add(1);
        }
        //개수 카운팅 부분
        ++_count;

        _pushUps.add(element);
      }else if (IsElbowDown && (_state == 'up') && lowerBodyConditon){
        _state = 'down';
        int start = DateTime.now().second;
      }

     }
    
  }
}