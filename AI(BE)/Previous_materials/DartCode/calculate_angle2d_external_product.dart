import 'dart:math'as m;


double calculateAngle2D(List<double> a, List<double> b, List<double> c, {int direction = 1}){
  /*
  this function is divided by left and right side because this function uses external product
  input : a, b, c -> landmarks with shape [x,y,z]
  direction -> int -1 or 1 (default is 1)
   -1 means Video(photo) for a person's left side and 1 means Video(photo) for a person's right side
  output : angle between vector 'ba' and 'bc' with range 0~360
  */
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



double CalcurateAngleRight(
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