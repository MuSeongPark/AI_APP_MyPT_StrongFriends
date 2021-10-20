import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/pull_up_analysis.dart';
import 'package:mypt/models/push_up_analysis.dart';
import 'package:mypt/models/squat_analysis.dart';
import 'package:mypt/models/workout_analysis.dart';
import 'package:get/get.dart';
import 'package:mypt/screens/analysis/workout_result_page.dart';

import 'camera_view.dart';
import '../painter/pose_painter.dart';
import '../utils/function_utils.dart';

class PoseDetectorView extends StatefulWidget { // using mlkit poseDetector object
  PoseDetectorView(
      {Key? key, required this.workoutName, required this.targetCount})
      : super(key: key);
  String workoutName;
  int targetCount;

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector(
      poseDetectorOptions:
          PoseDetectorOptions(model: PoseDetectionModel.accurate));
  // PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  late WorkoutAnalysis workoutAnalysis;

  @override
  void initState() { // initiate workoutAnalysis abstract class object
    super.initState();
    if (widget.workoutName == 'Push Up') { 
      workoutAnalysis = PushUpAnalysis(targetCount: widget.targetCount);
    } else if (widget.workoutName == 'Squat') {
      workoutAnalysis = SquatAnalysis(targetCount: widget.targetCount);
    } else if (widget.workoutName == 'Pull Up') {
      workoutAnalysis = PullUpAnalysis(targetCount: widget.targetCount);
    } else {
      workoutAnalysis = PullUpAnalysis(targetCount: widget.targetCount);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: widget.workoutName,
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      workoutAnalysis: workoutAnalysis,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    if (workoutAnalysis.end && workoutAnalysis.detecting) {
      workoutAnalysis.saveWorkoutResult(); // send workout result to firebase server
      workoutAnalysis.stopDetecting(); 
    }
    final poses = await poseDetector.processImage(inputImage);
    print('Found ${poses.length} poses');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      if (poses.isNotEmpty &&
          workoutAnalysis.detecting &&
          !workoutAnalysis.end) {
        workoutAnalysis.detect(poses[0]); // analysis workout by poseDector pose value
        print("현재 ${widget.workoutName} 개수 :");
        print(workoutAnalysis.count);
      }
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
