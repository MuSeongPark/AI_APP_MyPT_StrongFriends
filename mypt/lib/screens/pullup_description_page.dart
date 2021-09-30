import 'package:flutter/material.dart';
import 'package:mypt/utils/build_appbar.dart';

class PullUpDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(child: Text('PullUp')),
    );
  }
}
