import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mypt/models/workout_result.dart';

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
  WorkoutResult workoutResult;

  ResultPage({Key? key, required this.workoutResult}) : super(key: key);
}

class _ResultPageState extends State<ResultPage> {
  late List<GDPData> _chartData;
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
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.workoutResult.workoutName} 운동 분석', style: subHeader),
          Text('운동횟수 : ${widget.workoutResult.count}', style: subHeader),
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
    for (int i=0; i<widget.workoutResult.workoutFeedback!.feedbackNames!.length; i++){
      GDPData(widget.workoutResult.workoutFeedback!.feedbackNames![i], widget.workoutResult.workoutFeedback!.feedbackCounts![i]);
    }
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
