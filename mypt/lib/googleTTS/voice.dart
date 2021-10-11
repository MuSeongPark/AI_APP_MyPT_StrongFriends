
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Voice{
  final FlutterTts tts = FlutterTts();
  Voice() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.5);
    tts.setVolume(1);
    tts.setQueueMode(1);
  }

  void sayStart() async {
    tts.speak('시작합니다.');
    await tts.awaitSpeakCompletion(true);
  }

  void countingVoice(int count) async {
    if (count ~/ 5 == 0){
      String countStr = count.toString();
      tts.speak(countStr + '개');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayStretchElbow(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('팔꿈치를 더 펴 주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayBendElbow(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('팔꿈치를 더 굽혀 주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayStretchElbowAndShoulder(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('팔꿈치와 어깨를 더 펴주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayHipUp(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('골반을 올려주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayHipDown(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('골반을 내려주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayHipKnee(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('엉덩이과 무릎이 같이 내려가야합니다');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayKneeUp(int count) async {
    if (count ~/3 == 0){
      tts.speak('무릎을 올리세요');
      await tts.awaitSpeakCompletion(true);
    }

  }

  void sayStretchKnee(int count) async {
    if (count ~/3 == 0){
      tts.speak('무릎을 펴세요');
      await tts.awaitSpeakCompletion(true);
    }

  }

  void sayBendKnee(int count) async {
    if (count ~/3 == 0){
      tts.speak('무릎을 굽히세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayKneeOut(int count) async {
    if (count ~/3 == 0){
      tts.speak('무릎과 발이 수직이 되게 하세요');
      await tts.awaitSpeakCompletion(true);
    }

  }

  void sayUp(int count) async {
    if (count ~/3 == 0){
      tts.speak('끝까지 올라가세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayElbowFixed(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('팔꿈치를 고정하세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayFast(int count) async {
    if (count ~/ 3 == 0){
      tts.speak('조금 천천히 해주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }

  void sayGood1() async {
    tts.speak('좋아요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayGood2() async {
    tts.speak('잘하고 있어요');
    await tts.awaitSpeakCompletion(true);

  }
}