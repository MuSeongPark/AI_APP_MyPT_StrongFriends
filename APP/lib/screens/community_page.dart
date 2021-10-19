import 'package:flutter/material.dart';
import 'package:mypt/components/video_listview.dart';
import 'package:mypt/theme.dart';

class CommunityPage extends StatelessWidget {
  final List<String> best3PostureList = [
    'https://www.youtube.com/watch?v=rMXzGCq_xdQ',
    'https://www.youtube.com/watch?v=DY468QPyylA',
    'https://www.youtube.com/watch?v=xtZgE8ZAez0',
  ];

  final List<String> best3MilitaryExerciseList = [
    'https://www.youtube.com/watch?v=0DsXTSHo3lU',
    'https://www.youtube.com/watch?v=jj6ze_eqmYI',
    'https://www.youtube.com/watch?v=VtadZPVaglY',
  ];

  final List<String> guideRoutineList = [
    'https://www.youtube.com/watch?v=QCN6jSXkhR8',
    'https://www.youtube.com/watch?v=s14NQ6Cz4QE',
    'https://www.youtube.com/watch?v=KXYi6bI-UPE',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이달의 BEST 3 장병 운동 자세', style: subHeader),
              SizedBox(height: 5),
              VideoListView(urlList: best3PostureList),
            ],
          ),
          Divider(
            thickness: 3.5,
            color: kBlueColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('군 장병을 위한 운동 BEST 3', style: subHeader),
              SizedBox(height: 5),
              VideoListView(urlList: best3MilitaryExerciseList),
            ],
          ),
          Divider(
            thickness: 3.5,
            color: kBlueColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('초보자 기본 가이드 루틴', style: subHeader),
              SizedBox(height: 5),
              VideoListView(urlList: guideRoutineList),
            ],
          ),
        ],
      ),
    );
  }
}
