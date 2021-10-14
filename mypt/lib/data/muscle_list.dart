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
      description: '''
        푸시업의 가장 기본적인 자세입니다.
        AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.

        1. 팔이 충분히 수축하지 않음. 
        2. 팔이 충분히 이완하지 않음.
        3. 골반이 올라간 상태로 운동.
        4. 골반이 내려간 상태로 운동.
        5. 무릎이 내려간 상태로 운동.
        6. 운동수행숙도가 너무 빠름''',
      isReadyForAI: true,
      imageUrl:
          'https://image.freepik.com/free-photo/young-powerful-sportsman-training-push-ups-dark-wall_176420-537.jpg',
    ),
  },
  'Diamond Push Up': {
    'image':
        'https://st2.depositphotos.com/1518767/8491/i/950/depositphotos_84912988-stock-photo-man-doing-diamond-push-ups.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Diamond Push Up',
      description:
          '''기본적인 푸시업보다 좀 더 팔의 간격을 좁힌 후 손의 모양을 다이아몬드 모양처럼 만들고 운동하는 푸시업입니다.

이 푸시업은 가슴 근육에도 자국이 오지만 삼두근에 좀 더 집중할 수 있도록 해주는 푸시업입니다.

이 운동은 생각보다 난이도가 있어 초보자분들은 무릎을 바닥에 대고 하시는 것을 추천드립니다.''',
      isReadyForAI: false,
      imageUrl:
          'https://st2.depositphotos.com/1518767/8491/i/950/depositphotos_84912988-stock-photo-man-doing-diamond-push-ups.jpg',
    )
  },
  'Bench Press': {
    'image':
        'https://image.freepik.com/free-photo/focused-man-doing-workout-weight-bench_329181-14155.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Bench Press',
      description: '''
1. 어깨 너비에서 조금 더 벌려 바벨을 잡아준다.
2. 허리는 살짝 굽어서 등에 아치 형태를 만들어 준다. 이와 동시에 등 상부를 벤치에 밀착시켜 견갑을 고정시켜준다.
3. 바벨을 내리는 위치는 가슴 중앙에 올 수 있게끔 한다.
4. 바벨을 직각에서 15도 가량 사선으로 들어 올린다.
''',
      isReadyForAI: false,
      imageUrl:
          'https://image.freepik.com/free-photo/focused-man-doing-workout-weight-bench_329181-14155.jpg',
    )
  },
  'Barbell Curl': {
    'image':
        'https://images.pexels.com/photos/1431282/pexels-photo-1431282.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Diamond Push Up',
      description: '''바벨컬

      바벨컬을 통해 이두운동을 할 수 있습니다
      AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.
      ''',
      isReadyForAI: false,
      imageUrl:
          'https://images.pexels.com/photos/1431282/pexels-photo-1431282.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    )
  },
};

Map<String, Map<String, dynamic>> legsExerciseList = {
  'Squat': {
    'image':
        'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Squat',
      description: '''
      스쿼트의 가장 기본적인 자세입니다.
      AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.

      1. 무릎이 충분히 수축하지 않음. 
      2. 무릎이 충분히 이완하지 않음.
      3. 무릎에 비해 엉덩이를 과도하게 사용해서 운동.
      4. 엉덩이에 비해 무릎을 과도하게 사용해서 운동.
      5. 무릎이 발끝보다 더 튀어나옴.
      6. 운동수행숙도가 너무 빠름''',
      isReadyForAI: true,
      imageUrl:
          'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    ),
  },
  'Lunge': {
    'image':
        'https://images.pexels.com/photos/5067670/pexels-photo-5067670.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Lunge',
      description: '''
      런지의 가장 기본적인 자세입니다.
      AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.''',
      isReadyForAI: false,
      imageUrl:
          'https://images.pexels.com/photos/5067670/pexels-photo-5067670.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
  },
  'DeadLift': {
    'image':
        'https://images.pexels.com/photos/791763/pexels-photo-791763.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'DeadLift',
      description: '''
      데드리프트의 가장 기본적인 자세입니다.
      AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.''',
      isReadyForAI: false,
      imageUrl:
          'https://images.pexels.com/photos/791763/pexels-photo-791763.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
  },
};

Map<String, Map<String, dynamic>> pullUpExerciseList = {
  'Pull Up': {
    'image':
        'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Pull Up',
      description: '''
        풀업의 가장 기본적인 자세입니다.
        AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.

        1. 팔이 충분히 수축하지 않음. 
        2. 팔이 충분히 이완하지 않음.
        3. 팔이 앞뒤로 과도하게 움직임.
        4. 반동을 사용해서 운동.
        5. 운동수행숙도가 너무 빠름''',
      isReadyForAI: true,
      imageUrl:
          'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    ),
  },
  'Pull Up': {
    'image':
        'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Pull Up',
      description: '''
        풀업의 가장 기본적인 자세입니다.
        AI 자세분석으로 안좋은 자세가 있는지 알려드립니다.

        1. 팔이 충분히 수축하지 않음. 
        2. 팔이 충분히 이완하지 않음.
        3. 팔이 앞뒤로 과도하게 움직임.
        4. 반동을 사용해서 운동.
        5. 운동수행숙도가 너무 빠름''',
      isReadyForAI: true,
      imageUrl:
          'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    ),
  },
};
