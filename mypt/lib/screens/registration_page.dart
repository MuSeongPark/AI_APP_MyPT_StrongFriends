import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/custom_textfield_form.dart';
import 'package:mypt/components/google_signin_button.dart';
import 'package:mypt/screens/home_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:mypt/theme.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo_mypt.png',
                  height: mediaquery.height * 0.2,
                  width: mediaquery.width * 0.8,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Registration',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _userNameTextField(),
                _passwordTextField(),
                _buildDivider(),
                _buildRegistrationButton(mediaquery),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: CustomTextFieldForm(
        text: 'Password',
        fValidate: (value) => value!.isEmpty ? "Please enter password" : null,
        tController: _passwordTextController,
      ),
    );
  }

  Padding _userNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomTextFieldForm(
        text: 'Username',
        fValidate: (value) => value!.isEmpty ? "Please enter username" : null,
        tController: _userNameTextController,
      ),
    );
  }

  Widget _buildRegistrationButton(Size mediaquery) {
    return Container(
      width: mediaquery.width,
      child: TextButton(
        onPressed: () {
          Get.to(RegistrationPage());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            'Next',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(Size mediaquery) {
    return Container(
      width: mediaquery.width,
      child: TextButton(
        onPressed: () {
          Get.to(HomePage());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            'Register',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
          Text('OR'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
