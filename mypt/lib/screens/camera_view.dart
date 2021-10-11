import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import '../models/push_up_analysis.dart';
import '../models/squat_analysis.dart';
import '../models/workout_analysis.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      required this.onImage,
      this.initialDirection = CameraLensDirection.back,
      required this.workoutAnalysis,})
      : super(key: key);

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
          child: widget.workoutAnalysis.detecting ?
          Icon(Icons.stop_circle_rounded, size: 40 ) :
          Icon(Icons.play_arrow_rounded, size: 40),
          onPressed: widget.workoutAnalysis.detecting ?
          () => {widget.workoutAnalysis.stopAnalysing()} :
          () => {widget.workoutAnalysis.startDetecting()},
        ));
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
            alignment: Alignment.centerLeft,
            child:showDescription(),
            ),)
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
        // mounted 가 왜있는 걸까
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

    widget.onImage(inputImage); // pose_detector_view의 processImage 함수 사용됨
    // 여기서 pose를 구하고 pose를 색칠함
  }

  Widget showDescription() {
    String processingString = '운동분석준비중';
    if(widget.workoutAnalysis.detecting){
      processingString = '운동분석중';
    }
    return Column(
      children: [
        Text(processingString),
        Text("${widget.title} 개수: ${widget.workoutAnalysis.count}"),
        _buildAngleText(),
        _buildFeedbackText()
      ],
    );
  }

  Widget _buildAngleText() {
    List<Widget> li = <Widget>[];
    for (String key in widget.workoutAnalysis.tempAngleDict.keys.toList()) {
      try {
        if (widget.workoutAnalysis.tempAngleDict[key]?.isNotEmpty){
          li.add(Text(
            "$key angle : ${widget.workoutAnalysis.tempAngleDict[key]?.last}"));
        }
      } catch (e) {
        print("앵글을 텍스트로 불러오는데 에러. 에러코드 : $e");
      }
    }
    return Column(children: li);
  }

  Widget _buildFeedbackText() {
    List<Widget> li = <Widget>[];
    for (String key in widget.workoutAnalysis.feedBack.keys.toList()) {
      try {
        if (widget.workoutAnalysis.feedBack[key]?.isNotEmpty){
          li.add(Text("$key : ${widget.workoutAnalysis.feedBack[key]?.last}"));
        }
      } catch (e) {
        print("피드백 결과를 불러오는데 에러. 에러코드 : $e");
      }
    }
    return Column(children: li);
  }
}
