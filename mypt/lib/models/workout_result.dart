
class WorkoutResult{
  String? user;
  String? workoutName;
  int? count;
  WorkoutFeedback? workoutFeedback;
  int? score;

  WorkoutResult({
    this.user,
    this.workoutName,
    this.count,
    this.workoutFeedback,
    this.score
  });

  factory WorkoutResult.fromJson(Map<String, dynamic> json){
    return WorkoutResult(
      workoutName: json['feedback_name'],
      count: json['count'],
      workoutFeedback: WorkoutFeedback.fromJson(json['workout_feedback']),
      score: json['score']
    );
  }
}

class WorkoutFeedback{
  List<String>? feedbackNames;
  List<int>? feedbackCounts;

  WorkoutFeedback({this.feedbackNames, this.feedbackCounts});

  factory WorkoutFeedback.fromJson(Map<String, dynamic> json){
	return WorkoutFeedback(
    feedbackNames: List<String>.from(json['feedback_name']),
    feedbackCounts: List<int>.from(json['feedback_count'])
	);
  }
}