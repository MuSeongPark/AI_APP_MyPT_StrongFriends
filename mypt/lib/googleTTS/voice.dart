import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

//import 'package:flutter_tts/flutter_tts_web.dart';
enum TtsState { playing, stopped }

class Voice{
  final FlutterTts tts = FlutterTts();

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  Voice() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.6);
    tts.setVolume(1);
    tts.setQueueMode(1);
  }

  void sayStart() async {
    tts.speak('시작합니다.');
  }

  void countingVoice(int count) async {
    String countStr = count.toString();
    tts.speak(countStr + '개');
    
  }

  void sayStretchElbow() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('팔을 펴세요');
    }
  }

  void sayBendElbow() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('팔을 굽히세요');
    }
  }

  void sayStretchElbowAndShoulder() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('팔과 어깨를 펴세요');
    }
  }

  void sayHipUp() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('골반을 올리세요');
    }
  }

  void sayHipDown() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('골반을 내리세요');
    }
  }

  void sayHipKnee() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('엉덩이와 무릎을 같이 내리세요');
    }
  }

  void sayKneeUp() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('무릎을 올리세요');
    }
  }

  void sayStretchKnee() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('무릎을 펴세요');
    }
  }

  void sayBendKnee() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('무릎을 굽히세요');
    }
  }

  void sayKneeOut() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('무릎과 발이 수직이 아닙니다.');
    }
  }

  void sayDontUseRecoil(int count) async {
    if (count ~/ 3 == 0) {
      tts.speak('반동을 사용하지 말아주세요');
      await tts.awaitSpeakCompletion(true);
    }
  }
  
  void sayUp() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('끝까지 올라가세요');
    }
  }

  void sayElbowFixed() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('팔꿈치를 고정하세요');
    }
  }

  void sayFast() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('천천히 하세요');
    }
  }

  void sayGood1() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('좋아요');
    }
  }

  void sayGood2() async {
    if (isStopped){
      ttsState = TtsState.playing;
      tts.speak('잘하고 있어요');
    }
  }

  void stopState(){
    ttsState = TtsState.stopped;
  }

  void ttsOff(){
    tts.stop();
  }
}
