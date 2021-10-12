import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/screens/pose_detector_view.dart';
import 'package:get/get.dart';

class CameraTestingPage extends StatelessWidget {
  const CameraTestingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: FittedBox(
          child: TextButton(
            child: Row(
              children: const [
                Text('Record your form'),
                Icon(Icons.camera),
              ],
            ),
            onPressed: () {
              Get.to(PoseDetectorView(workoutName: 'pushup', targetCount: 10));
            },
          ),
        ),
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MyPT',
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(width: 5),
          Icon(LineAwesomeIcons.dumbbell),
        ],
      ),
      centerTitle: true,
    );
  }
}
