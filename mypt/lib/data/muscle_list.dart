import 'package:mypt/screens/exercise_listview.dart';
import 'package:mypt/screens/workout_description_page.dart';

Map<String, dynamic> muscleList = {
  'chest': ExerciseListView(
    exerciseList: chestExerciseList,
  ),
  'legs': ExerciseListView(
    exerciseList: legsExerciseList,
  ),
  /*
  'legs': WorkoutDescriptionPage(
    workoutName: 'squat',
  ),
  */
  'back': ExerciseListView(
    exerciseList: pullUpExerciseList,
  ),
};

Map<String, Map<String, dynamic>> chestExerciseList = {
  'Push Up': {
    'image':
        'https://image.freepik.com/free-photo/young-powerful-sportsman-training-push-ups-dark-wall_176420-537.jpg',
    'nextPage': WorkoutDescriptionPage(workoutName: 'pushup'),
  },
  'Diamond Push Up': {
    'image':
        'https://st2.depositphotos.com/1518767/8491/i/950/depositphotos_84912988-stock-photo-man-doing-diamond-push-ups.jpg',
    'nextPage': WorkoutDescriptionPage(workoutName: 'diamondPushUp')
  }
  // '/images/description_pushup.jpg'
};

Map<String, Map<String, dynamic>> legsExerciseList = {
  'Squat': {
    'image':
        'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    'nextPage': WorkoutDescriptionPage(workoutName: 'squat'),
  },
};

Map<String, Map<String, dynamic>> pullUpExerciseList = {
  'Pull Up': {
    'image':
        'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    'nextPage': WorkoutDescriptionPage(workoutName: 'pullup'),
  },

};
