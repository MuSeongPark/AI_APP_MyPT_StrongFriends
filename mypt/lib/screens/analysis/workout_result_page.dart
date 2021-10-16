import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/utils.dart';

class WorkoutResultPage extends StatefulWidget {
  @override
  State<WorkoutResultPage> createState() => _WorkoutResultPageState();
  WorkoutResult workoutResult;

  WorkoutResultPage({required this.workoutResult});
}

class _WorkoutResultPageState extends State<WorkoutResultPage> {
  late List<FeedbackData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '운동 ${widget.workoutResult.workoutName} 자세분석 결과}',
          style: subHeader,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: ${customSum(widget.workoutResult.score!)}',
              style: subHeader,
              textAlign: TextAlign.center,
            ),
            Flexible(
              flex: 1,
              child: _buildBarChart(),
            ),
            Flexible(
              flex: 1,
              child: Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    color: kLightIvoryColor,
                    child: _buildTextFeedback()
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Scaffold(
      body: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<FeedbackData, String>(
            color: Colors.red[400],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            name: '잘못된 자세',
            dataSource: _chartData,
            xValueMapper: (FeedbackData feedbackData, _) => feedbackData.feedback,
            yValueMapper: (FeedbackData feedbackData, _) => feedbackData.count,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
          )
        ],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
      ),
    );
  }

  SfCircularChart _buildRadialChart() {
    return SfCircularChart(
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<FeedbackData, String>(
          dataSource: _chartData,
          xValueMapper: (FeedbackData feedbackData, _) => feedbackData.feedback,
          yValueMapper: (FeedbackData feedbackData, _) => feedbackData.count,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            textStyle: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
          enableTooltip: true,
          cornerStyle: CornerStyle.bothCurve,
          maximumValue: 150,
        )
      ],
    );
  }

  List<FeedbackData> getChartData() {
    List<FeedbackData> chartData = <FeedbackData>[];
    if (widget.workoutResult.workoutName == 'push_up'){
      for (int i=0; i<widget.workoutResult.feedbackCounts!.length; i++){
        chartData.add(FeedbackData(pushUpFeedbackNames[i], widget.workoutResult.feedbackCounts![i]));
      }
    } else if (widget.workoutResult.workoutName == 'pull_up'){
      for (int i=0; i<widget.workoutResult.feedbackCounts!.length; i++){
        chartData.add(FeedbackData(pullUpFeedbackNames[i], widget.workoutResult.feedbackCounts![i]));
      }
    } else { // 'squat'
      for (int i=0; i<widget.workoutResult.feedbackCounts!.length; i++){
        chartData.add(FeedbackData(squatFeedbackNames[i], widget.workoutResult.feedbackCounts![i]));
      }
    }
    return chartData;
  }

  Widget _buildTextFeedback(){
    /*
    Text text;
    List<String> feedbackNames;
    if (widget.workoutResult.workoutName == 'push_up'){
      feedbackNames = pushUpFeedbackNames;
    } else if (widget.workoutResult.workoutName == 'pull_up'){
      feedbackNames = pullUpFeedbackNames;
    } else {
      feedbackNames = squatFeedbackNames;
    }
    if (firstFeedback==-1 && secondFeedback==-1){
      text = Text("완벽한 자세로 운동하셨습니다!");
    } else if (secondFeedback==-1){
      text = Text("안좋은 자세 한가지\n${feedbackNames[firstFeedback]}");
    }
    */
    return Text("가장 많이 나온 안좋은 자세\n");
  }
}

class FeedbackData {
  FeedbackData(this.feedback, this.count);
  final String feedback;
  final int count;
}

List<String> pushUpFeedbackNames = [
  '충분한 이완 X', 
  '충분한 수축 X', 
  '골반이 올라감', 
  '골반이 내려감', 
  '무릎이 내려감',
  '운동속도가 너무 빠름',
];

List<String> pullUpFeedbackNames = [
  '충분한 이완 X', 
  '충분한 수축 X', 
  '팔이 너무 흔들림', 
  '반동을 사용함', 
  '운동속도가 너무 빠름',
];

List<String> squatFeedbackNames = [
  '충분한 이완 X', 
  '충분한 수축 X', 
  '엉덩이만 과도하게 사용', 
  '무릎만 과도하게 사용', 
  '수축시 무릎이 발끝보다 튀어나옴',
  '운동속도가 너무 빠름',
];