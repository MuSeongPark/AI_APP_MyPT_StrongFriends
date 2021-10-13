import 'package:flutter/material.dart';

class WorkoutResult {
  int? id;
  String? user;
  String? workoutName;
  int? count;
  List<int>? feedbackCounts;
  List<int>? score;

  WorkoutResult(
      {required this.id,
      required this.user,
      required this.workoutName,
      required this.count,
      required this.feedbackCounts,
      required this.score});

  factory WorkoutResult.fromJson(Map<String, dynamic> json) {
    return WorkoutResult(
        id: json['id'],
        user: json['user'],
        workoutName: json['feedback_name'],
        count: json['count'],
        feedbackCounts: List<int>.from(json['feedback_counts']),
        score: List<int>.from(json['score']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'workout_name': workoutName,
        'count': count,
        'feedback_counts': feedbackCounts,
        'score': score
      };
}
