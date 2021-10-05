// 자료구조 구성중. 무시해도 됌

import 'package:mypt/screens/workout_description_page.dart';

Map<String, Map<String, dynamic>> chestExerciseList = {
  'Push Up': {
    'image': 'URL',
    'nextPage': WorkoutDescriptionPage(workoutName: 'pushup'),
  },
  'Diamond Push Up': {
    'image': 'URL',
    'nextPage': WorkoutDescriptionPage(workoutName: 'diamondPushUp')
  }
};
