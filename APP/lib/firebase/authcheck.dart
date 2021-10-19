import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mypt/firebase/loading.dart';
import 'package:mypt/screens/home_page.dart';
import 'package:mypt/screens/login_page.dart';

class Authcheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          if (snapshot.hasData) {
            return HomePage();
          }
          return LoginPage();
        }
      },
    );
  }
}
