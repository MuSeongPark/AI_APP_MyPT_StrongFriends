import 'dart:math';
import 'calculate_angle.dart' as ca;

void main(List<String> args) {
  List firstJointMark;
  List midJointMark;
  List endJointMark;

  double angle;
  double elbowAngle;
  String state = 'None';


  int counter = 0;
  Map jointIndx = {
    'left_elbow':[15,13,11],
    'left_hip':[11,23,25],
    'left_knee':[23,25,27]
  };


  Map AngleDict = {
    'left_elbow':[],
    'left_hip':[],
    'left_knee':[]
  };

  Map tempAngleDict = {
    'left_elbow':[2],
    'left_hip':[],
    'left_knee':[1]
  };

  Map FeedBack = {
    'Is_elbow_up':[],
    'Is_elbow_down':[],
    'hip_condition':[]
  };
  print(tempAngleDict['left_elbow'].last);

  List keys = jointIndx.keys.toList();
  List vals = jointIndx.values.toList();
  /*
  if (results.pose_landmarks){ //포즈 추정한 관절값들을 가져오는 메서드
      for (int i = 0; i<jointIndx.length; i++){
        firstJointMark, midJointMark, endJointMark = findXYZ(vals[i],landmark); //findXYZ로 처음, 중간, 끝의 관절 xyz값을 받아와야함
        angle = ca.CalcurateAngleLeft(firstJointMark,midJointMark,endJointMark);
        AngleDict[keys[i]].add(angle);
        tempAngleDict[keys[i]].add(angle);

      }
      elbowAngle = tempAngleDict['left_elbow'].last;
      if ((elbowAngle > 135) & (state == 'down')){
        state = 'up';
        counter += 1;
        
        if (listMax(tempAngleDict['left_elbow']) > 160){
          FeedBack['Is_elbow_up'].add(1);
        
        }else{
          FeedBack['Is_elbow_up'].add(0);
        }

        if (listMin(tempAngleDict['left_elbow']) < 90){
          FeedBack['Is_elbow_down'].add(1);
        }else{
          FeedBack['Is_elbow_down'].add(0);
        }



        //푸쉬업 하나당 골반 판단
        if (listMin(tempAngleDict['left_hip']) < 160){
          FeedBack['hip_condition'].add(1);

        }else if (listMax(tempAngleDict['left_hip']) > 220){
          FeedBack['hip_condition'].add(2);
        }else{
          FeedBack['hip_condition'].append(0);
        }

        //초기화
        tempAngleDict['left_elbow'] = [];
        tempAngleDict['left_hip'] = [];
        tempAngleDict['left_knee'] = [];
        
      }
      if ((elbowAngle < 130) & (state == 'up')){
        state = 'down';
      }
  }
  */
  
}

double listMax(List<double> list){
  list.sort();
  return list.last;
}

double listMin(List<double> list){
  list.sort();
  return list.first;
}
