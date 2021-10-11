import '../utils.dart';

import 'package:mypt/googleTTS/voice.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_analysis.dart';

const Map<String, List<int>> jointIndx = {
  'right_hip': [12, 24, 26],
  'right_knee': [24, 26, 28]
};

//음성
final Voice speaker = Voice();

class SquatAnalysis implements WorkoutAnalysis {


  Map<String, List<double>> _tempAngleDict = {
    'right_hip': <double>[],
    'right_knee': <double>[],
    'avg_hip_knee': <double>[],
    'foot_length': <double>[],
    'toe_location': <double>[]
  };

  Map<String, List<int>> _feedBack = {
    'is_relaxation': <int>[],
    'is_contraction': <int>[],
    'hip_knee_relation': <int>[],
    'is_knee_in': <int>[],
    'is_speed_good': <int>[]
  };

  // Map<String, double> _minMaxAngle = {
  //   'min_hip'
  // }
  bool isStart = false;

  bool isKneeOut = false;
  late double footLength;
  late double kneeX;
  late double toeX;

  late int start;
  List<String> _keys = jointIndx.keys.toList();
  List<List<int>> _vals = jointIndx.values.toList();
  String _state = 'up'; // up, down, none
  int _count = 0;
  int get count => _count;
  get feedBack => _feedBack;
  get tempAngleDict => _tempAngleDict;
  
  bool _detecting = false;
  get detecting => _detecting;
  

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

    if (_state == 'up'){
      footLength = getDistance(landmarks[PoseLandmarkType.values[32]]!,
          landmarks[PoseLandmarkType.values[30]]!);
      _tempAngleDict['foot_length']!.add(footLength);
      _tempAngleDict['toe_location']!.add(toeX);
    } else if (_tempAngleDict['foot_length']!.isEmpty && _tempAngleDict['toe_location']!.isEmpty){

      if (customSum(_tempAngleDict['foot_length']!) /_tempAngleDict['foot_length']!.length +
          customSum(_tempAngleDict['toe_location']!) /_tempAngleDict['toe_location']!.length * 0.20 < kneeX){
        isKneeOut = true;
      }

    }
    double hipAngle = _tempAngleDict['right_hip']!.last;
    double kneeAngle = _tempAngleDict['right_knee']!.last;
    _tempAngleDict['avg_hip_knee']!.add((hipAngle + kneeAngle) / 2);

    if (!isStart && hipAngle > 160 && hipAngle < 205 && kneeAngle > 160 && kneeAngle < 205){
      isStart = true;
    }

    if (!isStart){
      int indx = _tempAngleDict['right_hip']!.length - 1;
      _tempAngleDict['right_knee']!.removeAt(indx);
      _tempAngleDict['avg_hip_knee']!.removeAt(indx);

    }else{
      if (isOutlierSquats(_tempAngleDict['right_hip']!, 0) || isOutlierSquats(_tempAngleDict['right_knee']!, 1)){
        int indx = _tempAngleDict['right_hip']!.length - 1;
        _tempAngleDict['right_knee']!.removeAt(indx);
        _tempAngleDict['avg_hip_knee']!.removeAt(indx);
      }else{
        bool isHipUp = hipAngle < 215;
        bool isHipDown = hipAngle > 240;
        bool isKneeUp = kneeAngle > 147.5;

        if (isHipUp && isKneeUp && _state == 'down') {
          //개수 카운팅
          ++_count;
          speaker.countingVoice(_count);
          int end = DateTime.now().second;
          _state = 'up';
          
          if (listMin(_tempAngleDict['right_hip']!) < 195) {
            //엉덩이를 완전히 이완
            speaker.sayGood1();
            _feedBack['is_relaxation']!.add(1);
          } else {
            //엉덩이 덜 이완
            speaker.sayStretchKnee(count);
            _feedBack['is_relaxation']!.add(0);
          }
          if (listMax(_tempAngleDict['right_hip']!) > 270) {
            //엉덩이가 완전히 내려간 경우
            //speaker.sayGood2();
            _feedBack['is_contraction']!.add(1);
          } else {
            //엉덩이가 덜 내려간 경우
            speaker.sayHipDown(count);
            _feedBack['is_contraction']!.add(0);
          }
          if (listMax(_tempAngleDict['avg_hip_knee']!) > 205) {
            //엉덩이가 먼저 내려간 경우
            speaker.sayHipKnee(count);
            _feedBack['hip_knee_relation']!.add(1);
          } else if (listMin(_tempAngleDict['avg_hip_knee']!) < 165) {
            //무릎이 먼저 내려간 경우
            speaker.sayHipKnee(count);
            _feedBack['hip_knee_relation']!.add(2);
          } else {
            //무릎과 엉덩이가 균형있게 내려간 경우
            speaker.sayGood2();
            _feedBack['hip_knee_relation']!.add(0);
          }
          if (isKneeOut) {
            //무릎과 발이 수직이 되지 않는 경우
            speaker.sayKneeOut(count);
            _feedBack['is_knee_in']!.add(0);
          } else {
            //무릎과 발이 수직으로 잘 하는 경우
            speaker.sayGood1();
            _feedBack['is_knee_in']!.add(1);
          }
          if ((end - start) < 1) {
            speaker.sayFast(count);
            _feedBack['is_speed_good']!.add(0);
          } else {
            _feedBack['is_speed_good']!.add(1);
          }

          if (_feedBack['is_contraction']!.last == 1) {
            //엉덩이가 완전히 내려간 경우
            if (_feedBack['is_contraction']!.last == 1) {
              //엉덩이를 완전히 이완
              if (_feedBack['is_knee_in']!.last == 0) {
                //무릎과 발이 수직이 되지 않는 경우
                speaker.sayKneeOut(count);

              } else {
                //무릎과 발이 수직으로 잘 하는 경우
                if (_feedBack['is_knee_in']!.last == 1) {
                  //엉덩이가 먼저 내려간 경우
                  speaker.sayHipKnee(count);

                } else if (_feedBack['is_knee_in']!.last == 2) {
                  //무릎이 먼저 내려간 경우
                  speaker.sayHipKnee(count);

                } else {
                  //무릎과 엉덩이가 균형있게 내려간 경우
                  if (_feedBack['is_knee_in']!.last == 0) {
                    //속도가 빠른 경우
                    speaker.sayFast(count);

                  } else {
                    //속도가 적당한 경우
                    speaker.sayGood1();
                  }
                }
              }
            } else {
              //엉덩이 덜 이완
              speaker.sayStretchKnee(count);
            }

          } else {
            //엉덩이가 덜 내려간 경우
            speaker.sayHipDown(count);
          }

          //초기화
          _tempAngleDict['right_hip'] = <double>[];
          _tempAngleDict['right_knee'] = <double>[];
          _tempAngleDict['avg_hip_knee'] = <double>[];
          _tempAngleDict['foot_length'] = <double>[];
          _tempAngleDict['toe_location'] = <double>[];


          isKneeOut = false;
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
      int isRelaxation = _feedBack['is_relaxation']![i];
      int isContraction = _feedBack['is_contraction']![i];
      int isHipKneeGood = (_feedBack['hip_knee_relation']![i] == 0) ? 1 : 0;
      int isKneeIn = _feedBack['is_knee_in']![i];
      int isSpeedgood = _feedBack['is_speed_good']![i];
      score.add(isRelaxation * 10 +
          isContraction * 20 +
          isHipKneeGood * 50 +
          isKneeIn * 13 +
          isSpeedgood * 7);
    }
    return score;
  }

  @override
  void startDetecting(){
    _detecting = true;
  }

  void stopDetecting(){
    _detecting = false;
  }
}
