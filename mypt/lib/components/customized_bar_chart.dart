import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/models/workout_result.dart';

class CustomizedBarChart extends StatefulWidget {
  CustomizedBarChart({Key? key, required this.workoutResult}) : super(key: key);
  WorkoutResult workoutResult;

  @override
  State<StatefulWidget> createState() => CustomizedBarChartState();
}

class CustomizedBarChartState extends State<CustomizedBarChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  late List<String> feedbackNames;

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  initState() {
    super.initState();
    if(widget.workoutResult.workoutName == 'push_up'){
      feedbackNames = pushUpFeedbackNames;
    } else if(widget.workoutResult.workoutName == 'pull_up'){
      feedbackNames = pullUpFeedbackNames;
    } else { // squat
      feedbackNames = squatFeedbackNames;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    '운동 분석 결과',
                    style: TextStyle(
                        color: Color(0xff0f4a3c),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${widget.workoutResult.workoutName}', // 서버에서 운동 종목 받아야 함
                    style: const TextStyle(
                        color: Color(0xff379982),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  // 서버에서 값 받아오기
  List<BarChartGroupData> showingGroups() => List.generate(widget.workoutResult.feedbackCounts!.length, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.workoutResult.feedbackCounts![i].toDouble(), isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = feedbackNames[0];
                  break;
                case 1:
                  weekDay = feedbackNames[1];
                  break;
                case 2:
                  weekDay = feedbackNames[2];
                  break;
                case 3:
                  weekDay = feedbackNames[3];
                  break;
                case 4:
                  weekDay = feedbackNames[4];
                  break;
                case 5:
                  weekDay = feedbackNames[5];
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return feedbackNames[0];
              case 1:
                return feedbackNames[1];
              case 2:
                return feedbackNames[2];
              case 3:
                return feedbackNames[3];
              case 4:
                return feedbackNames[4];
              case 5:
                return feedbackNames[5];
              default:
                return feedbackNames[0];
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}

List<String> pushUpFeedbackNames = [
  '이완X', 
  '수축X', 
  '골반이\n올라감', 
  '골반이\n내려감', 
  '무릎이\n내려감',
  '운동속도\n빠름',
];

List<String> pullUpFeedbackNames = [
  '이완X', 
  '수축X', 
  '팔이\n흔들림', 
  '반동을\n사용함', 
  '운동속도가\n빠름',
];

List<String> squatFeedbackNames = [
  '이완X', 
  '수축X',  
  '엉덩이만\n사용', 
  '무릎만\n사용', 
  '무릎이\n앞으로 나옴',
  '운동속도가\n빠름',
];