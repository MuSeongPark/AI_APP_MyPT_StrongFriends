import 'package:flutter/material.dart';
import 'package:mypt/components/customized_bar_chart.dart';
import 'package:mypt/theme.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';

class ResultPage3 extends StatelessWidget {
  const ResultPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomizedBarChart(),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  color: kLightIvoryColor,
                  child: Center(child: Text('피드백')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
