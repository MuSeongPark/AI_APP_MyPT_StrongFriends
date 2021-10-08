import 'dart:core';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:math' as m;

List<List<double>> findXyz(
    List<int> indexList, Map<PoseLandmarkType, PoseLandmark> landmarks) {
  List<List<double>> list = [];
  for (int i = 0; i < 3; i++) {
    // !를 사용해도 될까
    PoseLandmark? poseLandmark =
        landmarks[PoseLandmarkType.values[indexList[i]]];
    double x = poseLandmark!.x;
    double y = poseLandmark.y;
    double z = poseLandmark.z;
    List<double> iXyz = [x, y, z];
    list.add(iXyz);
  }
  return list;
}

double calculateAngle3DLeft(List<List<double>> listXyz) {
  List<double> a = listXyz[0];
  List<double> b = listXyz[1];
  List<double> c = listXyz[2];
  double externalZ =
      (b[0] - a[0]) * (b[1] - c[1]) - (b[1] - a[1]) * (b[0] - c[0]);

  List<double> baVector = customExtraction(b, a);
  List<double> bcVector = customExtraction(b, c);
  List<double> multi = customMultiplication(baVector, bcVector);

  double dotResult = customSum(multi);
  double baSize = vectorSize(baVector);
  double bcSize = vectorSize(bcVector);

  double radi = m.acos(dotResult / (baSize * bcSize));
  double angle = (radi * 180.0 / m.pi);

  angle.abs();
  if (externalZ < 0) {
    angle = 360 - angle;
  }
  return angle;
}

double calculateAngle3DRight(List<List<double>> listXyz) {
  List<double> a = listXyz[0];
  List<double> b = listXyz[1];
  List<double> c = listXyz[2];
  double externalZ =
      (b[0] - a[0]) * (b[1] - c[1]) - (b[1] - a[1]) * (b[0] - c[0]);

  List<double> baVector = customExtraction(b, a);
  List<double> bcVector = customExtraction(b, c);
  List<double> multi = customMultiplication(baVector, bcVector);

  double dotResult = customSum(multi);
  double baSize = vectorSize(baVector);
  double bcSize = vectorSize(bcVector);

  double radi = m.acos(dotResult / (baSize * bcSize));
  double angle = (radi * 180.0 / m.pi);

  angle.abs();
  if (externalZ > 0) {
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
      (index) => index + 1 > a.length
          ? 0
          : a[index] - (index + 1 > b.length ? 0 : b[index]));

  return base;
}

double vectorSize(List<double> vector) {
  double num = 0;
  for (int i = 0; i < vector.length; i++) {
    num += vector[i] * vector[i];
  }
  num = m.sqrt(num);
  return num;
}

double listMax(List<double> list) {
  list.sort();
  return list.last;
}

double listMin(List<double> list) {
  list.sort();
  return list.first;
}

double getDistance(PoseLandmark lmFrom, PoseLandmark lmTo) {
  double x2 = (lmFrom.x - lmTo.x) * (lmFrom.x - lmTo.x);
  double y2 = (lmFrom.y - lmTo.y) * (lmFrom.y - lmTo.y);
  return m.sqrt(x2 + y2);
}
