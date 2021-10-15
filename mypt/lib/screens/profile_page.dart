import 'package:flutter/material.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNoTitleAppBar(),
      body: Center(
        child: Text('Welcome to Jongin Jun\'s Profile Page'),
      ),
    );
  }
}