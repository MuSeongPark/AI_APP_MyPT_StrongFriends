// 아직 구상중 무시해도 됌

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/theme.dart';
import 'package:get/get.dart';

class ExerciseTile extends StatelessWidget {
  final String? workoutName;
  final String? imageUrl;
  final String? videoId;
  final nextPage;

  ExerciseTile({
    @required this.workoutName,
    this.imageUrl,
    this.videoId,
    @required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.network(
              '$imageUrl',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 30,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.25 * 0.3,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25 * 0.3,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$workoutName',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(LineAwesomeIcons.history),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    /*
    ListTile(
      leading: imageUrl == null
          ? ClipRRect(
              child: Container(
                color: kLightIvoryColor,
                height: 80,
                width: 80,
              ),
              borderRadius: BorderRadius.circular(15),
            )
          : Image.network(
              '',
              fit: BoxFit.cover,
            ),
      title: Text('$workoutName'),
      onTap: () {
        Get.to(nextPage);
      },
    );
    */
  }
}
