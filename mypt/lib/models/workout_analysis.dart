import 'package:google_ml_kit/google_ml_kit.dart';

abstract class WorkoutAnalysis {
  late String _state;
  int _count = 0;
  get count => _count;
  late List<String> _recordKeys;
  late Map<String, List<int>> _feedBack;
  late Map<String, List<double>> _tempAngleDict;
  get tempAngleDict => _tempAngleDict;
  get feedBack => _feedBack;
  bool detecting = false;

  void detect(Pose pose) {}

  List<int> workoutToScore() {
    return [0];
  }

  void startDetecting(){
    detecting = true;
  }
}
