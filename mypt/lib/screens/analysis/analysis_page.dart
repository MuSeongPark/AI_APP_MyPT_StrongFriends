import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisPage extends StatefulWidget {
  final String? muscle;

  AnalysisPage(this.muscle);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState(muscle);
}

class _AnalysisPageState extends State<AnalysisPage> {
  final String? muscle;

  _AnalysisPageState(this.muscle);

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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                '운동 분석',
                style: subHeader,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                '98',
                style: subHeader,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              flex: 1,
              child: SfCircularChart(
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  RadialBarSeries<GDPData, String>(
                    dataSource: _chartData,
                    xValueMapper: (GDPData data, _) => data.continent,
                    yValueMapper: (GDPData data, _) => data.gdp,
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
              ),
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Push Up', 78),
      GDPData('Squat', 89),
      GDPData('Pull Up', 100),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
