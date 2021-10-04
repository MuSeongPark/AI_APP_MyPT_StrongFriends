import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordGrid extends StatelessWidget {
  final String? muscle;
  final Color? backgroundColor;
  final nextPage;
  final textStyle = const TextStyle(
      fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 15);

  // ignore: use_key_in_widget_constructors
  const RecordGrid({
    @required this.muscle,
    @required this.backgroundColor,
    @required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(nextPage);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 120,
        width: double.infinity,
        child: Row(
          children: [_buildWorkoutName(), const Spacer(), _buildRecord()],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 7.0) // changes position of shadow
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutName() {
    return Text('$muscle'.toUpperCase(), style: textStyle);
  }

  Widget _buildRecord() {
    return Column(
      children: [
        Text('분석횟수 : 0', style: textStyle),
        Text('평균운동개수 : 15.5개', style: textStyle),
        Text('평균운동자세정확도 : 80%', style: textStyle)
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
