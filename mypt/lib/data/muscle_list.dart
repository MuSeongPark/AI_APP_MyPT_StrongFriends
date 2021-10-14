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
  'abs' : ExerciseListView(
    exerciseList : absExerciseList,
  )
};

// Next Pages of Muscle List above.
Map<String, Map<String, dynamic>> chestExerciseList = {
  'Push Up': {
    'image':
        'https://image.freepik.com/free-photo/young-powerful-sportsman-training-push-ups-dark-wall_176420-537.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Push Up',
      description: '''푸시업 자세분석으로 네가지 기능을 제공합니다.

        1. 팔꿈치 관절이 제대로 수축하는가. 
        2. 팔꿈치 관절이 제대로 이완되는가.
        3. 엉덩이가 일직선을 유지하는가.
        4. 무릎이 일직선을 유지하는가.''',
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
      imageUrl:
          'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    ),
  },
};

Map<String, Map<String, dynamic>> pullUpExerciseList = {
  'Pull Up': {
    'image':
        'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Pull Up',
      description:
          '''풀업은 철봉을 손으로 잡고 당겨 상완이두근과 등 근육뿐 아니라 상체 근육 전체를 골고루 단련시킬 수 있는 운동입니다.
      1. 어깨 너비보다 넓게 팔을 벌려 바를 잡는다.
      2. 견갑을 고정시켜준다. (숄더패킹)
      3. 팔꿈치가 엽구리에 닿는다는 생각으로 바를 당겨준다.
      ''',
      isReadyForAI: true,
      imageUrl:
          'https://image.freepik.com/free-photo/male-body-builder-doing-pull-ups-gym_13339-53191.jpg',
    ),
  },
};

Map<String, Map<String, dynamic>> absExerciseList = {
  'Crunch': {
    'image':
        'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    'nextPage': WorkoutDescriptionPage(
      workoutName: 'Abs',
      description: '',
      isReadyForAI: false,
      imageUrl:
          'https://st3.depositphotos.com/12985790/18581/i/600/depositphotos_185816256-stock-photo-side-view-young-african-american.jpg',
    ),
  },
};
