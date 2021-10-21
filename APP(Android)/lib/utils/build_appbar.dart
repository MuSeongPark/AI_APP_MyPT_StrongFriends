import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MyPT',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 36,
            ),
          ),
          SizedBox(width: 5),
          Icon(LineAwesomeIcons.dumbbell),
        ],
      ),
      centerTitle: true,
    );
  }