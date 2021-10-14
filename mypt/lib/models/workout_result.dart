import 'package:flutter/material.dart';
import 'dart:convert';

class WorkoutResult {
  final String? uid;
  final String? user;
  final String? workoutName;
  final int? count;
  final List<int>? feedbackCounts;
  final List<int>? score;

  WorkoutResult(
      {this.uid,
      this.user,
      this.workoutName,
      this.count,
      this.feedbackCounts,
      this.score});

  factory WorkoutResult.fromJson(Map<String, dynamic> json) {
    return WorkoutResult(
        uid: json['uid'],
        user: json['user'],
        workoutName: json['feedback_name'],
        count: json['count'],
        feedbackCounts: List<int>.from(json['feedback_counts']),
        score: List<int>.from(json['score']));
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'user': user,
        'workout_name': workoutName,
        'count': count,
        'feedback_counts': feedbackCounts,
        'score': score
      };
}
