import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text('Welcome to Jongin Jun\'s Profile Page'),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MyPT',
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(width: 5),
          Icon(LineAwesomeIcons.dumbbell),
        ],
      ),
      centerTitle: true,
    );
  }
}
