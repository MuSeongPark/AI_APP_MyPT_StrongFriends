
import "dart:math" as m

void main() {

  
}


  

import 'dart:html';
import '../utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';


double getDistance(double lmFrom, double lmTo){
  double x2 = (lmFrom.x - lmTo.x) * (lmFrom.x - lmTo.x);
  double y2 = (lmFrom.y - lmTo.y) * (lmFrom.y - lmTo.y);
  return m.sqrt(x2+y2);
}

class SquatAnalysis extends WorkoutAnalysis{
  final Map<String, List<int>> _jointIndx = {
    'right_hip':[12,24,26],
    'right_knee':[24,26,28],
  };

  Map<String, List<double>> _tempAngleDict = {
    'right_hip':[],
    'right_knee':[],
    'avg_hip_knee':[],
  };

  List<List> squats = [];
  String squatState = 'up';
  bool IsKneeOut = false;
  late double footLength;
  late double kneeX;
  late double toeX;


  late List _keys;
  late List _vals;
  late String _state; // up, down, none
  int _count = 0;
  int get count => _count;
  
  SquatAnalysis(){
    _keys = _jointIndx.keys.toList();
    _vals = _jointIndx.values.toList();
    _state = 'up';
  }

  void detect(Pose pose){ // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
     if (landmarks != null){ //포즈 추정한 관절값들을 가져오는 메서드
      for (int i = 0; i<_jointIndx.length; i++){
        List<List<double>> listXyz = findXyz(_vals[i], landmarks);
        double angle = calculateAngle3DLeft(listXyz);
        _tempAngleDict[_keys[i]].add(angle);
      }
      kneeX = landmarks[26].x;
      toeX = landmarks[32].x;
      footLength = getDistance(landmarks[32], landmarks[30]);
      if (toeX + footLength*0.195 < kneeX){
        IsKneeOut = true;
      }
      double hipAngle = _tempAngleDict['right_hip'].last;
      double kneeAngle = _tempAngleDict['right_knee'].last;
      _tempAngleDict['avg_hip_knee'].add((hipAngle+kneeAngle) / 2);

      if ((hipAngle < 235) && (kneeAngle > 130) && (squatState == 'down')){
        squatState = 'up';
        ++_count;
        List<int> element = [];
        if (listMin(_tempAngleDict['right_hip']) < 195){
          element.add(1);
        } else{
          element.add(0);
        }
        if (listMax(_tempAngleDict['right_hip']) > 270){
          element.add(1);
        }else{
          element.add(0);
        }
        _tempAngleDict['right_hip'] = [];
        _tempAngleDict['right_knee'] = [];
        if (listMax(_tempAngleDict['avg_hip_knee'])>193){
          element.add(1);

        }else if(listMin(_tempAngleDict['avg_hip_knee']) < 176){
          element.add(2);
        }else{
          element.add(0);
        }
        _tempAngleDict['avg_hip_knee'] = [];
        if (IsKneeOut){
          element.add(0);
        }else{
          element.add(1);
        }
        squats.add(element);
        IsKneeOut = false;

      }
      if ((hipAngle > 245) && (kneeAngle < 130) && (squatState == 'up')){
        squatState = 'down';
      }


     }
    
  }
}