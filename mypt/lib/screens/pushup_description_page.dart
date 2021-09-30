import 'package:flutter/material.dart';
import 'package:mypt/utils/build_appbar.dart';

class PushUpDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(child: Text('PushUp')),
    );
  }
}
