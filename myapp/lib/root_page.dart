import 'package:flutter/material.dart';
import 'package:myapp/Login_relation/login_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('root_page');
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen(){
    return LoginPage();
  }
}