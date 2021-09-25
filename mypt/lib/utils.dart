import 'dart:core';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:math' as m;

List<List<double>> findXyz(List<int> indexList, Map<PoseLandmarkType, PoseLandmark> landmarks){
  List<List<double>> list = [];
  for(int i=0; i<3; i++){
    // !를 사용해도 될까
    List<double> iXyz = [landmarks[indexList[i]]!.x, landmarks[indexList[i]]!.y,
      landmarks[indexList[i]]!.z];
    list.add(iXyz);
  }
  return list;
}

double calculateAngle3DLeft(
    List<double> a,
    List<double> b,
    List<double> c
    )
{
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
  if (externalZ > 0){
    angle = 360 - angle;
  }
  return angle;
}

double customSum(List list) {
  //isEmptyError(list);
  double numb = 0;

  for (int i = 0; i < list.length; i++) {
    numb += list[i];
  }
  return numb;
}

List<double> customMultiplication(List<double> a, List<double> b) {
  List<double> base = List<double>.generate(
      a.length,
          (index) => index + 1 > a.length
          ? 1
          : a[index] * (index + 1 > b.length ? 1 : b[index]));

  return base;
}


List<double> customExtraction(List<double> a, List<double> b) {
  List<double> base = List<double>.generate(
      a.length,
          (index) =>
      index + 1 > a.length
          ? 0
          : a[index] - (index + 1 > b.length ? 0 : b[index]));

  return base;
}

double vectorSize(List<double> vector){
  double num = 0;
  for (int i = 0; i < vector.length; i++) {
    num += vector[i] * vector[i];
  }
  num = m.sqrt(num);
  return num;
}