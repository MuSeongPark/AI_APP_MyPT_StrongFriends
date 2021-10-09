import 'package:mypt/utils.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

double calculateAngle2D(List<List<double>> listXyz, {int direction = 1}){
  /*
  this function is divided by left and right side because this function uses external product
  input : a, b, c -> landmarks with shape [x,y,z]
  direction -> int -1 or 1 (default is 1)
   -1 means Video(photo) for a person's left side and 1 means Video(photo) for a person's right side
  output : angle between vector 'ba' and 'bc' with range 0~360
  */
  List<double> a = listXyz[0];
  List<double> b = listXyz[1];
  List<double> c = listXyz[2];
  
  double externalZ = (b[0]-a[0])*(b[1]-c[1]) - (b[1]-a[1])*(b[0]-c[0]);
  List<double> baVector = customExtraction(b, a);
  List<double> bcVector = customExtraction(b, c);
  List<double> multi = customMultiplication(baVector, bcVector);

  double dotResult = customSum(multi);
  double baSize = vectorSize(baVector);
  double bcSize = vectorSize(bcVector);

  double radi = m.acos(dotResult / (baSize*bcSize));
  double angle = (radi * 180.0/m.pi);

  angle.abs();
  if ((externalZ * direction) > 0){
    angle = 360 - angle;
  }
  return angle;

}

double calculateAngle2DVector(List<double> v1, List<double> v2){
  List<double> multi = customMultiplication(v1, v2);

  double dotResult = customSum(multi);
  double v1Size = vectorSize(v1);
  double v2Size = vectorSize(v2);

  double radi = m.acos(dotResult / (v1Size*v2Size));
  double angle = (radi * 180.0/m.pi);

  angle.abs();
  return angle;
}



class PullUpAnalysis extends WorkoutAnalysis{
  final Map<String, List<int>> _jointIndx = {
    'right_elbow':[16,14,12],
    'right_shoulder':[14,12,24],
  };

  Map _tempAngleDict = {
    'right_elbow':[],
    'right_shoulder':[],
    'elbow_normY':[],
  };

  List<List<int>> pullUps = [];
  
  bool IsKneeOut = false;
  bool IsTotallyContraction = false;

  int HumanPixelCnt = 0;

  late int start;
  late List _keys;
  late List _vals;
  late String _state; // up, down, none
  int _count = 0;
  int get count => _count;
  
  PullUpAnalysis(){
    _keys = _jointIndx.keys.toList();
    _vals = _jointIndx.values.toList();
    _state = 'down';
  }

  void detect(Pose pose){ // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
     if (landmarks != null){ //포즈 추정한 관절값들을 가져오는 메서드
      for (int i = 0; i<_jointIndx.length; i++){
        List<List<double>> listXyz = findXyz(_vals[i], landmarks);
        double angle = calculateAngle2D(listXyz, direction: 1);

        if (_keys[i] == 'right_shoulder' && (angle < 30)){
          angle = 359;
        }
        _tempAngleDict[_keys[i]].add(angle);
      }
      List<double> arm = [landmarks[14].x - landmarks[16].x, landmarks[14].y - landmarks[16].y];
      List<double> normY = [0,1];
      _tempAngleDict['elbow_normY'].add(calculateAngle2DVector(arm, normY));

      double elbowAngle = _tempAngleDict['right_elbow'].last;
      double shoulderAngle = _tempAngleDict['right_shoulder'].last;
      bool IsElbowUp = elbowAngle < 97.5;
      bool IsElbowDown = elbowAngle > 110 && elbowAngle < 180;
      bool IsShoulderUp = shoulderAngle > 250 && shoulderAngle < 360;

      double rightMouthY = landmarks[10].y;
      double rightElbowY = landmarks[14].y;
      double rightWristY = landmarks[16].y;

      bool IsMouthUpperThanElbow = rightMouthY < rightElbowY;
      bool IsMouthUpperThanWrist = rightMouthY < rightWristY;

      if (IsElbowDown && !IsShoulderUp && _state == 'up' && !IsMouthUpperThanElbow){
        int end = DateTime.now().second;
        _state = 'down';
        List<int> element = [];
        //IsRelaxation
        if (listMax(_tempAngleDict['right_elbow']) > 145 && listMin(_tempAngleDict['right_shoulder']) < 250){
          element.add(1);
        }else{
          element.add(0);
        }
        //IsContraction
        if (IsTotallyContraction && (listMin(_tempAngleDict['right_elbow']) < 70)){
          element.add(1);
        }else{
          element.add(0);
        }
        _tempAngleDict['right_hip'] = [];
        _tempAngleDict['right_knee'] = [];
        IsTotallyContraction = false;
        //IsElbowStable
        if (listMax(_tempAngleDict['elbow_normY']) < 17){
          element.add(1);
        }else{
          element.add(0);
        }
        _tempAngleDict['elbow_normY'] = [];
        //IsSpeedGood
        if ((end - start) < 1.5){
          element.add(0);
        }else{
          element.add(1);
        }
        //개수 카운팅
        ++_count;

        pullUps.add(element);


      }else if (IsElbowUp && IsShoulderUp && _state == 'down' && IsMouthUpperThanElbow){
        _state = 'up';
        int start = DateTime.now().second;
      }
     }
    
  }
}