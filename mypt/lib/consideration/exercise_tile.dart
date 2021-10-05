// 아직 구상중 무시해도 됌

import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:get/get.dart';

class ExerciseTile extends StatelessWidget {
  final String? workoutName;
  final String? imageUrl;
  final nextPage;

  ExerciseTile({
    @required this.workoutName,
    this.imageUrl,
    @required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageUrl == null
          ? ClipRRect(
              child: Container(
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              borderRadius: BorderRadius.circular(15),
            )
          : Image.network(
              '',
              fit: BoxFit.cover,
            ),
      title: Text('$workoutName'),
      tileColor: kLightIvoryColor,
      onTap: () {
        Get.to(nextPage);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
