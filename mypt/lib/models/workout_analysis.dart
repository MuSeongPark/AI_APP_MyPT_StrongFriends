import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mypt/models/workout_result.dart';

abstract class WorkoutAnalysis {
  late String _state;
  late Map<String, List<int>> _feedBack;
  late Map<String, List<double>> _tempAngleDict;

  int _count = 0;
  bool _detecting = false;
  int targetCount;
  bool _end = false;

  get tempAngleDict => _tempAngleDict;
  get feedBack => _feedBack;
  get count => _count;
  get detecting => _detecting;
  get end => _end;

  WorkoutAnalysis({required this.targetCount});

  void detect(Pose pose) {}

  List<int> workoutToScore() {
    return [0];
  }

  void startDetecting() {
    _detecting = true;
  }

    Future<void> startDetectingDelayed() async {
  }

  void stopDetecting() {
    _detecting = false;
  }

  WorkoutResult makeWorkoutResult() {
    return WorkoutResult(
        user: 'user1',
        uid: "1",
        workoutName: 'workout',
        count: 0,
        feedbackCounts: [0],
        score: [0]);
  }

  void stopAnalysing() {
    _end = true;
  }

  Future<void> stopAnalysingDelayed() async {
    stopDetecting();
    await Future.delayed(const Duration(seconds: 2), () {
      stopAnalysing();
    });
  }

  void saveWorkoutResult() async {}
}
