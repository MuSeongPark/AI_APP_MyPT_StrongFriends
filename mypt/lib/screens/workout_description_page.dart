import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/screens/pose_detector_view.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';

class WorkoutDescriptionPage extends StatefulWidget {
  String workoutName;
  String description;
  bool isReadyForAI;
  String imageUrl;

  WorkoutDescriptionPage({
    required this.workoutName,
    required this.description,
    required this.isReadyForAI,
    required this.imageUrl,
  });

  @override
  State<WorkoutDescriptionPage> createState() => _WorkoutDescriptionPageState(
      workoutName: workoutName,
      description: description,
      imageUrl: imageUrl,
      isReadyForAI: isReadyForAI);
}

class _WorkoutDescriptionPageState extends State<WorkoutDescriptionPage> {
  int _repetition = 10;
  String workoutName;
  String description;
  String imageUrl;
  bool isReadyForAI;

  _WorkoutDescriptionPageState(
      {required this.workoutName,
      required this.description,
      required this.imageUrl,
      required this.isReadyForAI});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
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
            fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _buildPic() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Image.network(
              "$imageUrl",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      description,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return isReadyForAI
        ? Padding(
            padding: const EdgeInsets.all(15),
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
                          Get.to(
                            PoseDetectorView(
                              targetCount: _repetition,
                              workoutName: widget.workoutName,
                            ),
                          );
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
                  fontSize: 18,
                ),
              ),
            ),
          )
        : TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.8),
              minimumSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "AI 기술 준비중",
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
}
