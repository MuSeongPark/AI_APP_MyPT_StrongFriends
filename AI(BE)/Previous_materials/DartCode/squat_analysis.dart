
import "dart:math" as m;

import 'package:mypt/utils.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';


double getDistance(double lmFrom, double lmTo){
  double x2 = (lmFrom.x - lmTo.x) * (lmFrom.x - lmTo.x);
  double y2 = (lmFrom.y - lmTo.y) * (lmFrom.y - lmTo.y);
  return m.sqrt(x2+y2);
}

List<int> squatsToScore(List<List<int>> pushups){
  /*
  squats : [[element1],[element2],...]
  element : [IsRelaxation, IsContraction, HipKneeRelation, IsKneeIn, IsSpeedGood]
  */
  List<int> score = [];
  for (List<int> _e in pushups){ //_e는 pushups에 담겨있는 각각의 element
    int IsRelaxation = _e[0];
    int IsContraction = _e[1];
    int IsHipKneeGood = 0;
    if (_e[2] == 0){
      IsHipKneeGood = 1;
    }
    int IsKneeIn = _e[3];
    int IsSpeedGood = _e[4];
    score.add(IsRelaxation*10 + IsContraction*20 + IsHipKneeGood*50 + IsKneeIn*13 + IsSpeedGood*7);
  }
  return score;
}

class SquatAnalysis extends WorkoutAnalysis{
  final Map<String, List<int>> _jointIndx = {
    'right_hip':[12,24,26],
    'right_knee':[24,26,28],
  };

  Map _tempAngleDict = {
    'right_hip':[],
    'right_knee':[],
    'avg_hip_knee':[],
  };

  List<List<int>> squats = [];
  
  bool IsKneeOut = false;
  late double footLength;
  late double kneeX;
  late double toeX;

  late int start;
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
        double angle = calculateAngle3DRight(listXyz);
        _tempAngleDict[_keys[i]].add(angle);
      }
      kneeX = landmarks[26].x;
      toeX = landmarks[32].x;
      footLength = getDistance(landmarks[32], landmarks[30]);
      if ((toeX + footLength*0.195) < kneeX){
        IsKneeOut = true;
      }
      double hipAngle = _tempAngleDict['right_hip'].last;
      double kneeAngle = _tempAngleDict['right_knee'].last;
      _tempAngleDict['avg_hip_knee'].add((hipAngle+kneeAngle) / 2);
      
      bool IsHipUp = hipAngle < 235;
      bool IsHIpDown = hipAngle > 245;
      bool IsKneeUp = kneeAngle > 130;

      if (IsHipUp && IsKneeUp && (_state == 'down')){
        int end = DateTime.now().second;
        _state = 'up';
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
        if ((end - start) < 1){
          element.add(0);
        }else{
          element.add(1);
        }
        //개수 카운팅 부분
        ++_count;

        squats.add(element);
        IsKneeOut = false;

      }else if (IsHIpDown && !IsKneeUp && _state == 'up'){
        _state = 'down';
        int start = DateTime.now().second;
        
      }

     }
    
  }
}