
import 'package:flutter_tts/flutter_tts.dart';

class Voice{
  final FlutterTts tts = FlutterTts();
  Voice(){
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
    tts.setVolume(1);
    tts.awaitSpeakCompletion(true);
  }

  void countingVoice(int count){
    String countStr = count.toString();
    tts.speak(countStr + '개');
  }

  void sayStretchElbow(){
    tts.speak('팔꿈치를 더 펴 주세요');
  }

  void sayBendElbow(){
    tts.speak('팔꿈치를 더 굽혀 주세요');
  }

  void sayStretchElbowAndShoulder(){
    tts.speak('팔꿈치와 어깨를 더 펴주세요');
  }

  void sayHipUp(){
    tts.speak('골반을 올려주세요');
  }

  void sayHipDown(){
    tts.speak('골반을 내려주세요');
  }

  void sayHipKnee(){
    tts.speak('엉덩이과 무릎이 같이 내려가야합니다');
  }

  void sayKneeUp(){
    tts.speak('무릎을 올리세요');
  }

  void sayStretchKnee(){
    tts.speak('무릎을 펴세요');
  }

  void sayBendKnee(){
    tts.speak('무릎을 굽히세요');
  }

  void sayKneeOut(){
    tts.speak('무릎과 발이 수직이 되게 하세요');
  }

  void sayUp(){
    tts.speak('끝까지 올라가세요');
  }

  void sayElbowFixed(){
    tts.speak('팔꿈치를 고정하세요');
  }

  void sayFast(){
    tts.speak('조금 천천히 해주세요');
  }

  void sayGood1(){
    tts.speak('좋아요');
  }

  void sayGood2(){
    tts.speak('잘하고 있어요');
  }
}