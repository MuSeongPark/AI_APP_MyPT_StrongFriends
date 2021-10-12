import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:mypt/models/workout_result.dart';
import 'package:json_store/json_store.dart';
import 'package:mypt/models/analysis_counter.dart';
import 'package:sqflite/sqflite.dart'; 

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late WorkoutResult workoutResult;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    getWorkoutResult();
  }

  void getWorkoutResult() async {
    JsonStore jsonStore = JsonStore();
    Map<String, dynamic>? JsonWorkoutResult = await jsonStore.getItem('workout_result_0');
    workoutResult = WorkoutResult.fromJson(JsonWorkoutResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${workoutResult.workoutName} 운동 분석', style: subHeader),
          Text('운동횟수 : ${workoutResult.count}', style: subHeader),
          Expanded(
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                RadialBarSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  enableTooltip: true,
                  cornerStyle: CornerStyle.bothCurve,
                  maximumValue: 5000,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = <GDPData>[];
    for (int i=0; i<workoutResult.workoutFeedback!.feedbackNames!.length; i++){
      GDPData(workoutResult.workoutFeedback!.feedbackNames![i], workoutResult.workoutFeedback!.feedbackCounts![i]);
    }
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
