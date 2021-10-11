import 'dart:html';

import '../utils.dart';

import 'package:mypt/googleTTS/voice.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

const Map<String, List<int>> jointIndx = {
    'right_elbow':[16,14,12],
    'right_shoulder':[14,12,24],
  };

//음성
final Voice speaker = Voice();

class PullUpAnalysis implements WorkoutAnalysis{

  Map<String, List<double>> _tempAngleDict = {
    'right_elbow':<double>[],
    'right_shoulder':<double>[],
    'elbow_normY':<double>[],
  };

  Map<String, List<int>> _feedBack = {
    'is_relaxation': <int>[],
    'is_contraction': <int>[],
    'is_elbow_stable': <int>[],
    'is_speed_good': <int>[],
  };
  
  bool isKneeOut = false;
  bool isTotallyContraction = false;
  bool wasTotallyContraction = false;

  int humanPixelCnt = 0;

  late int start;
  List<String> _keys = jointIndx.keys.toList();
  List<List<int>> _vals = jointIndx.values.toList();

  String _state = 'down'; // up, down, none
  int _count = 0;
  int get count => _count;
  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  bool detecting = false;
  

  void detect(Pose pose){ // 포즈 추정한 관절값을 바탕으로 개수를 세고, 자세를 평가
    Map<PoseLandmarkType, PoseLandmark> landmarks = pose.landmarks;
    for (int i = 0; i<jointIndx.length; i++){
      List<List<double>> listXyz = findXyz(_vals[i], landmarks);
      double angle = calculateAngle2D(listXyz, direction: 1);

      if ((_keys[i] == 'right_shoulder') && (angle < 30)){
        angle = 359;
      }
      _tempAngleDict[_keys[i]]!.add(angle);
    }
    List<double> arm = [
      landmarks[PoseLandmarkType.values[14]]!.x - landmarks[PoseLandmarkType.values[16]]!.x,
      landmarks[PoseLandmarkType.values[14]]!.y - landmarks[PoseLandmarkType.values[16]]!.y];

    List<double> normY = [0,1];
    _tempAngleDict['elbow_normY']!.add(calculateAngle2DVector(arm, normY));

    double elbowAngle = _tempAngleDict['right_elbow']!.last;
    double shoulderAngle = _tempAngleDict['right_shoulder']!.last;
    bool isElbowUp = elbowAngle < 97.5;
    bool isElbowDown = elbowAngle > 110 && elbowAngle < 180;
    bool isShoulderUp = shoulderAngle > 268 && shoulderAngle < 360;

    double rightMouthY = landmarks[PoseLandmarkType.values[10]]!.y;
    double rightElbowY = landmarks[PoseLandmarkType.values[14]]!.y;
    double rightWristY = landmarks[PoseLandmarkType.values[16]]!.y;

    bool isMouthUpperThanElbow = rightMouthY < rightElbowY;
    bool isMouthUpperThanWrist = rightMouthY < rightWristY;

      //완전 수축 정의
    if (!isTotallyContraction && isMouthUpperThanWrist && elbowAngle < 100 && shoulderAngle > 280){
      isTotallyContraction = true;
    }else if (elbowAngle > 76 && !isMouthUpperThanWrist){
      isTotallyContraction = false;
      wasTotallyContraction = true;
    }



    if (isElbowDown && !isShoulderUp && _state == 'up' && !isMouthUpperThanElbow){
      //개수 카운팅
      ++_count;
      speaker.countingVoice(_count);

      int end = DateTime.now().second;
      _state = 'down';
      //IsRelaxation !
      if (listMax(_tempAngleDict['right_elbow']!) > 145 && listMin(_tempAngleDict['right_shoulder']!) < 250){
        //완전히 이완한 경우
        speaker.sayGood1();
        _feedBack['is_relaxation']!.add(1);
      }else{
        //덜 이완한 경우(팔을 덜 편 경우)
        speaker.sayStretchElbow();
        _feedBack['is_relaxation']!.add(0);
      }
      //IsContraction
      if (wasTotallyContraction){
        //완전히 수축
        speaker.sayGood2();
        _feedBack['is_contraction']!.add(1);
      }else{
        //덜 수축된 경우
        speaker.sayUp();
        _feedBack['is_contraction']!.add(0);
      }
      wasTotallyContraction = false;

      _tempAngleDict['right_hip'] = <double>[];
      _tempAngleDict['right_knee'] = <double>[];
      isTotallyContraction = false;

      //IsElbowStable
      if (listMax(_tempAngleDict['elbow_normY']!) < 25){
        //팔꿈치를 고정한 경우
        speaker.sayGood1();
        _feedBack['is_elbow_stable']!.add(1);
      }else{
        //팔꿈치를 고정하지 않은 경우
        speaker.sayElbowFixed();
        _feedBack['is_elbow_stable']!.add(0);
      }
      _tempAngleDict['elbow_normY'] = <double>[];
        
      //IsSpeedGood
      if ((end - start) < 1.5){
        //속도가 빠른 경우
        speaker.sayFast();
        _feedBack['is_speed_good']!.add(1);
      }else{
        //속도가 적당한 경우
        speaker.sayGood2();
        _feedBack['is_speed_good']!.add(0);
      }



    }else if (isElbowUp && isShoulderUp && _state == 'down' && isMouthUpperThanElbow){
      _state = 'up';
      start = DateTime.now().second;
    }
  }

  @override
  List<int> workoutToScore(){
    return [0];
  }

  @override
  void startDetecting(){
    detecting = true;
  }
}