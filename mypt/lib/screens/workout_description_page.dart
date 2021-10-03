import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypt/utils/build_appbar.dart';

class workoutDescriptionPage extends StatefulWidget {
  String workoutName;

  workoutDescriptionPage({Key? key, required this.workoutName}) : super(key: key);

  @override
  State<workoutDescriptionPage> createState() => _workoutDescriptionPageState(workoutName: workoutName);
}

class _workoutDescriptionPageState extends State<workoutDescriptionPage> {
  int _repetition = 10;
  String workoutName;
  Map<String, String> descriptionString = {
    'pushup': '푸쉬업 자세분석으로 네가지 기능을 제공합니다.\n1. 팔꿈치 관절이 제대로 수축하는가\n2. 팔꿈치 관절이 제대로 이완되는가\n3. 엉덩이가 일직선을 유지하는가\n4. 무릎이 일직선을 유지하는가\n',
    'pullup': '풀업 자세분석으로 네가지 기능을 제공합니다.\n1. \n2. \n3. \n4. \n',
    'squat': '스쿼트 자세분석으로 네가지 기능을 제공합니다.\n1. 무릎 관절이 제대로 수축하는가\n2. 무릎 관절이 제대로 이완되는가\n3. 무릎이 발끝을 넘어가지 않는가\n4. 허리가 곧게 펴져있는가.\n'};

  _workoutDescriptionPageState({required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
      children: [
        _buildHead(),
        _buildPic(),
        _buildDescription(),
        _buildInputString(),
        _buildButton(context)
      ],
    ),
    );
  }

  Widget _buildHead(){
    return Text(
            workoutName,
            style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
          );
  }
  
  Widget _buildPic(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: Image.asset(
            "assets/description_$workoutName.jpg",
            fit: BoxFit.cover,
        ),
      )),
    );
  }

  Widget _buildDescription(){
    return Text(
            descriptionString[workoutName]!,
            style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
          );
  }

    Widget _buildButton(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15.0), 
    child: Align(
      child: TextButton(
        onPressed: () {
          showCupertinoDialog(
            // 1. 추가
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text("$_repetition 번의 $workoutName 을 하시겠습니까?"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFff7643),
          minimumSize: const Size(300, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "운동을 시작",
          style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
        ),
      ),
    ));
  }

  Widget _buildInputString(){
    return Container(
      width: 300, 
      child: TextFormField(
        decoration: const InputDecoration(labelText: "운동횟수를 입력해주세요", labelStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )),
        onChanged: (String a){
          setState(() {_repetition = int.parse(a);}
          );}, 
    ));
  }
}
