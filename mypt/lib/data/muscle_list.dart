import 'package:mypt/screens/exercise_listview.dart';
import 'package:mypt/screens/workout_description_page.dart';

Map<String, dynamic> muscleList = {
  'chest': ExerciseListView(
    exerciseList: chestExerciseList,
  ),
  'legs': ExerciseListView(
    exerciseList: legsExerciseList,
  ),
  'back': ExerciseListView(
    exerciseList: pullUpExerciseList,
  ),
};

// Next Pages of Muscle List above.
Map<String, Map<String, dynamic>> chestExerciseList = {
  'Push Up': {
    'image':
        'https://image.freepik.com/free-photo/young-powerful-sportsman-training-push-ups-dark-wall_176420-537.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Push Up',
      description:
          '''푸시업 자세분석으로 네가지 기능을 제공합니다.

        1. 팔꿈치 관절이 제대로 수축하는가. 
        2. 팔꿈치 관절이 제대로 이완되는가.
        3. 엉덩이가 일직선을 유지하는가.
        4. 무릎이 일직선을 유지하는가.''',
      isReadyForAI: true,
      imageUrl: 'https://image.freepik.com/free-photo/young-powerful-sportsman-training-push-ups-dark-wall_176420-537.jpg',
    ),
  },
  'Diamond Push Up': {
    'image':
        'https://st2.depositphotos.com/1518767/8491/i/950/depositphotos_84912988-stock-photo-man-doing-diamond-push-ups.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Diamond Push Up',
      description: '''다이아몬드 푸시업

      기본적인 푸시업보다 좀 더 팔의 간격을 좁힌 후 손의 모양을 다이아몬드 모양처럼 만들고 운동하는 푸시업입니다.
      이 푸시업은 가슴 근육에도 자국이 오지만 삼두근에 좀 더 집중할 수 있도록 해주는 푸시업입니다.
      이 운동은 생각보다 난이도가 있어 초보자분들은 무릎을 바닥에 대고 하시는 것을 추천드립니다.
      ''',
      isReadyForAI: false,
      imageUrl: 'https://st2.depositphotos.com/1518767/8491/i/950/depositphotos_84912988-stock-photo-man-doing-diamond-push-ups.jpg',
    )
  }
  // '/images/description_pushup.jpg'
};

Map<String, Map<String, dynamic>> legsExerciseList = {
  'Squat': {
    'image':
        'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Squat',
      description: '',
      isReadyForAI: true,
      imageUrl: 'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    ),
  },
};

Map<String, Map<String, dynamic>> pullUpExerciseList = {
  'Pull Up': {
    'image':
        'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    'nextPage': WorkoutDescriptionPage(
        workoutName: 'Pull Up', description: '', isReadyForAI: true, imageUrl: 'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',),
  },
};
