import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

//import 'package:flutter_tts/flutter_tts_web.dart';
enum TtsState { playing, stopped }

class Voice {
  final FlutterTts tts = FlutterTts();

  Voice() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.55);
    tts.setVolume(1);
    tts.setQueueMode(1);
  }

  void sayStartDelayed() async{
    tts.speak('8초 후에 측정이 시작됩니다.');
  }

  void sayStart() async {
    tts.speak('시작합니다.');
  }

  void countingVoice(int count) async {
    String countStr = count.toString();
    await tts.speak(countStr + '개');
  }

  void sayStretchElbow(int count) async {
    if (count % 2 == 0) {
      tts.speak('팔을 펴세요');
    }
  }

  void sayBendElbow(int count) async {
    if (count % 2 == 0) {
      tts.speak('팔을 굽히세요');
    }
  }

  void sayStretchElbowAndShoulder(int count) async {
    if (count % 2 == 0) {
      tts.speak('팔과 어깨를 펴세요');
    }
  }

  void sayHipUp(int count) async {
    if (count % 2 == 0) {
      tts.speak('골반을 올리세요');
    }
  }

  void sayHipDown(int count) async {
    if (count % 2 == 0) {
      tts.speak('골반을 내리세요');
    }
  }

  void sayHipKnee(int count) async {
    if (count % 2 == 0) {
      tts.speak('엉덩이와 무릎을 같이 내리세요');
    }
  }

  void sayKneeUp(int count) async {
    if (count % 2 == 0) {
      tts.speak('무릎을 올리세요');
    }
  }

  void sayStretchKnee(int count) async {
    if (count % 2 == 0) {
      tts.speak('무릎을 펴세요');
    }
  }

  void sayBendKnee(int count) async {
    if (count % 2 == 0) {
      tts.speak('무릎을 굽히세요');
    }
  }

  void sayKneeOut(int count) async {
    if (count % 2 == 0) {
      tts.speak('무릎이 앞으로 갔어요');
    }
  }

  void sayDontUseRecoil(int count) async {
    if (count % 2 == 0) {
      tts.speak('반동을 이용하지 마세요.');
    }
  }

  void sayUp(int count) async {
    if (count % 2 == 0) {
      tts.speak('끝까지 올라가세요');
    }
  }

  void sayElbowFixed(int count) async {
    if (count % 2 == 0) {
      tts.speak('팔꿈치를 고정하세요');
    }
  }

  void sayFast(int count) async {
    if (count % 2 == 0) {
      tts.speak('천천히 하세요');
    }
  }

  void sayGood1(int count) async {
    if (count % 2 == 0) {
      tts.speak('좋아요');
    }
  }

  void sayGood2(int count) async {
    if (count % 2 == 0) {
      tts.speak('잘하고 있어요');
    }
  }

  void ttsOff() {
    tts.stop();
  }
}
