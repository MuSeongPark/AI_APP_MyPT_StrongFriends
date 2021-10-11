import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_result.dart';

abstract class WorkoutAnalysis {
  late String _state;
  int _count = 0;
  get count => _count;
  late Map<String, List<int>> _feedBack;
  late Map<String, List<double>> _tempAngleDict;
  get tempAngleDict => _tempAngleDict;
  get feedBack => _feedBack;
  bool _detecting = false;
  get detecting => _detecting;
  int targetCount;

  WorkoutAnalysis({required this.targetCount});

  void detect(Pose pose) {}

  List<int> workoutToScore() {
    return [0];
  }

  void startDetecting(){
    _detecting = true;
  }

  void stopDetecting(){
    _detecting = false;
  }

  WorkoutResult makeWorkoutResult(){
    return WorkoutResult();
  }
}
