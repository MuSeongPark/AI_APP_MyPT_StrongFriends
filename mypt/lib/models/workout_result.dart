
import 'package:flutter/material.dart';

class WorkoutResult{
  String? id;
  String? user;
  String? workoutName;
  int? count;
  WorkoutFeedback? workoutFeedback;
  List<int>? score;

  WorkoutResult({
    required this.id,
    required this.user,
    required this.workoutName,
    required this.count,
    required this.workoutFeedback,
    required this.score
  });

  factory WorkoutResult.fromJson(Map<String, dynamic> json){
    return WorkoutResult(
      id: json['id'],
      user: json['user'],
      workoutName: json['feedback_name'],
      count: json['count'],
      workoutFeedback: WorkoutFeedback.fromJson(json['workout_feedback']),
      score: List<int>.from(json['score'])
    );
  }

  Map<String, dynamic> toJson() =>{
    'id': id, 'user': user, 'workout_name': workoutName, 'count': count, 'workout_feedback': workoutFeedback?.toJson(), 'score': score
  };
}

class WorkoutFeedback{
  List<String>? feedbackNames;
  List<int>? feedbackCounts;

  WorkoutFeedback({required this.feedbackNames, required this.feedbackCounts});

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