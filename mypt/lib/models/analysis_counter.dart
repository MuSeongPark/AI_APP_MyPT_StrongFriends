
import 'package:flutter/material.dart';

class AnalysisCounter{
  int value;
  AnalysisCounter({required this.value});

  AnalysisCounter.fromJson(Map<String, dynamic> json) : value = json['value'];
  Map<String, dynamic> toJson() => {'value': value};
}