
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Voice{
  final FlutterTts tts = FlutterTts();
  Voice() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.5);
    tts.setVolume(1);
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

  void sayStretchElbow() async {
    tts.speak('팔꿈치를 더 펴 주세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayBendElbow() async {
    tts.speak('팔꿈치를 더 굽혀 주세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayStretchElbowAndShoulder() async {
    tts.speak('팔꿈치와 어깨를 더 펴주세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayHipUp() async {
    tts.speak('골반을 올려주세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayHipDown() async {
    tts.speak('골반을 내려주세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayHipKnee() async {
    tts.speak('엉덩이과 무릎이 같이 내려가야합니다');
    await tts.awaitSpeakCompletion(true);

  }

  void sayKneeUp() async {
    tts.speak('무릎을 올리세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayStretchKnee() async {
    tts.speak('무릎을 펴세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayBendKnee() async {
    tts.speak('무릎을 굽히세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayKneeOut() async {
    tts.speak('무릎과 발이 수직이 되게 하세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayUp() async {
    tts.speak('끝까지 올라가세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayElbowFixed() async {
    tts.speak('팔꿈치를 고정하세요');
    await tts.awaitSpeakCompletion(true);

  }

  void sayFast() async {
    tts.speak('조금 천천히 해주세요');
    await tts.awaitSpeakCompletion(true);

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