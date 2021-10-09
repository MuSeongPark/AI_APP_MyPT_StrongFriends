import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/app_data.dart';
import 'package:mypt/screens/pose_detector_view.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:provider/provider.dart';

class WorkoutDescriptionPage extends StatefulWidget {
  String workoutName;

  WorkoutDescriptionPage({Key? key, required this.workoutName})
      : super(key: key);

  @override
  State<WorkoutDescriptionPage> createState() =>
      _WorkoutDescriptionPageState(workoutName: workoutName);
}

class _WorkoutDescriptionPageState extends State<WorkoutDescriptionPage> {
  int _repetition = 10;
  String workoutName;
  Map<String, String> descriptionString = {
    'pushup':
        '푸쉬업 자세분석으로 네가지 기능을 제공합니다.\n1. 팔꿈치 관절이 충분히 수축하는가\n2. 팔꿈치 관절이 충분히 이완하는가\n3. 엉덩이가 일직선을 유지하는가\n4. 무릎이 일직선을 유지하는가\n5. 적당한 속도로 푸쉬업을 수행하는가',
    'pullup': '풀업 자세분석으로 네가지 기능을 제공합니다.\n1. 팔꿈치 관절이 충분히 수축하는가 \n2. 팔꿈치 관절이 충분히 이완하는가 \n3. 대칭을 유지하며 풀업을 하는가 \n 4. 적당한 속도로 풀업을 수행하는가 \n',
    'squat':
        '스쿼트 자세분석으로 네가지 기능을 제공합니다.\n1. 무릎 관절이 충분히 수축하는가\n2. 무릎 관절이 충분히 이완하는가\n3. 엉덩이와 무릎이 동시에 수축하고 이완하는가\n4. 무릎이 발끝을 너무 넘어가지 않는가\n5. 적당한 속도로 스쿼트를 수행하는가'
  };

  _WorkoutDescriptionPageState({required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildHead(),
            _buildPic(),
            _buildDescription(),
            _buildRepetitionButton(),
            _buildButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        workoutName.toUpperCase(),
        style: const TextStyle(
            fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  Widget _buildPic() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Image.asset(
              "images/description_$workoutName.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      descriptionString[workoutName]!,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Align(
        child: TextButton(
          onPressed: () {
            showCupertinoDialog(
              // 1. 추가
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text("$_repetition 번의 $workoutName 을(를) 하시겠습니까?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("확인"),
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(()=>
                      ChangeNotifierProvider(
                        create: (_) => AppData(),
                        child : PoseDetectorView(workoutName: workoutName)
                        ));
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text("취소"),
                    onPressed: () {
                      Get.back();
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
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

// 운동 횟수 기입 UI 디자인
  Widget _buildRepetitionButton() {
    return Container(
      color: Colors.white,
      height: 150,
      width: 320,
      child: Stack(
        children: [
          Positioned(
            top: 75,
            left: 0,
            child: InkWell(
              onTap: () {
                if (_repetition >= 5) {
                  setState(() {
                    _repetition -= 5;
                  });
                } else {
                  setState(() {
                    _repetition = 0;
                  });
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            left: 0,
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (_repetition >= 5) {
                    setState(() {
                      _repetition -= 5;
                    });
                  } else {
                    setState(() {
                      _repetition = 0;
                    });
                  }
                },
                child: const Text(
                  '-5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 50,
            child: InkWell(
              onTap: () {
                if (_repetition > 0) {
                  setState(() {
                    _repetition -= 1;
                  });
                }
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 50,
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (_repetition > 0) {
                    setState(() {
                      _repetition -= 1;
                    });
                  }
                },
                child: const Text(
                  '-1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 120,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                border: Border.all(width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 120,
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              child: Text(
                '$_repetition',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 50,
            child: InkWell(
              onTap: () {
                if (_repetition < 100) {
                  setState(() {
                    _repetition += 1;
                  });
                }
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 50,
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (_repetition < 100) {
                    setState(() {
                      _repetition += 1;
                    });
                  }
                },
                child: const Text(
                  '+1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            right: 0,
            child: InkWell(
              onTap: () {
                if (_repetition <= 95) {
                  setState(() {
                    _repetition += 5;
                  });
                } else if (_repetition > 95 && _repetition < 100) {
                  setState(() {
                    _repetition = 100;
                  });
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.green[300],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (_repetition <= 95) {
                    setState(() {
                      _repetition += 5;
                    });
                  } else if (_repetition > 95 && _repetition < 100) {
                    setState(() {
                      _repetition = 100;
                    });
                  }
                },
                child: const Text(
                  '+5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/* 이 코드는 유저가 숫자를 입력하지 않을 시 바로 CRASH. 이러한 사항 고려 안됌. TextFormField를 사용하길 희망할 시 수정 필요.
  Widget _buildInputString() {
    return Container(
      width: 300,
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: "운동횟수를 입력해주세요",
            labelStyle: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        onChanged: (String a) {
          setState(() {
            _repetition = int.parse(a);
          });
        },
      ),
    );
  }
  */
}
