
import 'package:flutter/material.dart';

class WorkoutResult{
  String? user;
  String? workoutName;
  int? count;
  WorkoutFeedback? workoutFeedback;
  List<int>? score;

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
      score: List<int>.from(json['score'])
    );
  }

  Map<String, dynamic> toJson() =>{
    'user': user, 'workout_name': workoutName, 'count': count, 'workout_feedback': workoutFeedback?.toJson(), 'score': score
  };
}

class WorkoutFeedback{
  List<String>? feedbackNames;
  List<int>? feedbackCounts;

  WorkoutFeedback({this.feedbackNames, this.feedbackCounts});

  factory WorkoutFeedback.fromJson(Map<String, dynamic> json){
	return WorkoutFeedback(
    feedbackNames: List<String>.from(json['feedback_names']),
    feedbackCounts: List<int>.from(json['feedback_counts'])
	);
  }
  Map<String, dynamic> toJson() => {
    'feedback_names': feedbackNames, 'feedback_counts': feedbackCounts
  };
}