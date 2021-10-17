import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypt/screens/analysis/workout_result_page.dart';
import 'package:mypt/screens/analysis/workout_result_page.dart';

import '../main.dart';
import '../models/push_up_analysis.dart';
import '../models/squat_analysis.dart';
import '../models/workout_analysis.dart';
import 'package:get/get.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    required this.title,
    required this.customPaint,
    required this.onImage,
    this.initialDirection = CameraLensDirection.back,
    required this.workoutAnalysis,
  }) : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  WorkoutAnalysis workoutAnalysis;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  File? _image;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: _switchLiveCamera,
              child: Icon(
                Icons.flip_camera_android_outlined,
                size: 40,
              ),
            ),
          )
        ],
      ),
      body: _liveFeedBody(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? _floatingActionButton() {
    return Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: widget.workoutAnalysis.end
              ? Icon(Icons.poll ,size: 40)
              : (widget.workoutAnalysis.detecting
                  ? Icon(Icons.pause, size: 40)
                  : Icon(Icons.play_arrow_rounded, size: 40)),
          onPressed: () async {
            try{
              if (widget.workoutAnalysis.end){
                int count = 0;
                Navigator.popUntil(context, (route) => count++ == 3);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkoutResultPage(workoutResult: widget.workoutAnalysis.makeWorkoutResult())
                  ),
                );
              } else if (widget.workoutAnalysis.detecting) {
                widget.workoutAnalysis.stopAnalysing();
              } else {
                widget.workoutAnalysis.startDetectingDelayed();
              }
            } catch(e){
              print(e);
            }
            }
        )
      );
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_controller!),
          if (widget.customPaint != null) widget.customPaint!,
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: _showWorkoutProcess(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: _showAngleText()
            )
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: _showFeedbackText()
            )
          )
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    if (_cameraIndex == 0)
      _cameraIndex = 1;
    else
      _cameraIndex = 0;
    await _stopLiveFeed();
    await _startLiveFeed();
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }

  Widget _showWorkoutProcess() {
    String processingString;
    if (widget.workoutAnalysis.end) {
      processingString = '운동분석종료';
    } else{
      if (widget.workoutAnalysis.detecting) {
        processingString = '운동분석중';
      } else {
        processingString = '운동분석대기중';
      }
    }
    return Column(
      children: [
        Text(processingString),
        Text("${widget.title} 개수: ${widget.workoutAnalysis.count}"),
      ],
      crossAxisAlignment: CrossAxisAlignment.center
    );
  }

  Widget _showAngleText() {
    List<Widget> li = <Widget>[Text("운동상태: ${widget.workoutAnalysis.state}", style: TextStyle(fontSize: 13),)];
    for (String key in widget.workoutAnalysis.tempAngleDict.keys.toList()) {
      try {
        if (widget.workoutAnalysis.tempAngleDict[key]?.isNotEmpty) {
          double angle = widget.workoutAnalysis.tempAngleDict[key]?.last;
          li.add(Text(
            "$key : ${double.parse((angle.toStringAsFixed(1)))}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13
            ),
          ));
        }
      } catch (e) {
        print("앵글을 텍스트로 불러오는데 에러. 에러코드 : $e");
      }
    }
    return Column(children: li, crossAxisAlignment: CrossAxisAlignment.start,);
  }

  Widget _showFeedbackText() {
    List<Widget> li = <Widget>[const Text("피드백 결과", style: TextStyle(fontSize: 13),)];
    for (String key in widget.workoutAnalysis.feedBack.keys.toList()) {
      try {
        if (widget.workoutAnalysis.feedBack[key]?.isNotEmpty) {
          String val = widget.workoutAnalysis.feedBack[key]?.last == 1 ? 'O' : 'X';
          li.add(Text(
            "$key : $val",
            style: TextStyle(
              color: widget.workoutAnalysis.feedBack[key]?.last == 1 ? Colors.redAccent : Colors.greenAccent,
              fontSize: 13
            ),
          ));
        }
      } catch (e) {
        print("피드백 결과를 불러오는데 에러. 에러코드 : $e");
      }
    }
    return Column(children: li, crossAxisAlignment: CrossAxisAlignment.start,);
  }
}
