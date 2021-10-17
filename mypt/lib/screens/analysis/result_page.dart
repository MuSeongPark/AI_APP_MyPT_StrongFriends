import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';
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
      appBar: buildNoTitleAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.workoutResult.workoutName} 운동 분석', style: subHeader),
          Text('운동횟수 : ${widget.workoutResult.count}', style: subHeader),
          Expanded(
            child: _buildChart(),
          ),
        ],
      ),
    );
  }
/* 민구님께서 나중에 주석 해제하시면 됩니다. 
  List<GDPData> getChartData() {
    final List<GDPData> chartData = <GDPData>[];
    for (int i=0; i<widget.workoutResult.workoutFeedback!.feedbackNames!.length; i++){
      chartData.add(GDPData(widget.workoutResult.workoutFeedback!.feedbackNames![i], widget.workoutResult.workoutFeedback!.feedbackCounts![i]));
    }
    return chartData;
  }
*/

  Widget _buildChart() {
    return Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: 'Continent wise GDP - 2021'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<GDPData, String>(
              name: 'GDP',
              dataSource: _chartData,
              xValueMapper: (GDPData gdp, _) => gdp.continent,
              yValueMapper: (GDPData gdp, _) => gdp.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(text: 'GDP in billions of U.S. Dollars'),
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 2900),
      GDPData('Europe', 23050),
      GDPData('N America', 24880),
      GDPData('Asia', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
