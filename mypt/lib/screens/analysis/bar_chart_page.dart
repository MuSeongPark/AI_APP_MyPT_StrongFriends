import 'package:flutter/material.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartPage extends StatefulWidget {
  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
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
      appBar: AppBar(
        title: Text(
          '운동 결과: 자세 분석',
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
              'Score: 98',
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
          BarSeries<GDPData, String>(
            color: Colors.red[400],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            name: '잘못된 자세',
            dataSource: _chartData,
            xValueMapper: (GDPData gdp, _) => gdp.continent,
            yValueMapper: (GDPData gdp, _) => gdp.gdp,
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
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Not Elbow Up', 6),
      GDPData('Not Elbow Down', 7),
      GDPData('Hip Up', 3),
      GDPData('Hip Down', 1),
      GDPData('Knee down', 0),
      GDPData('Speed Fast', 4),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
