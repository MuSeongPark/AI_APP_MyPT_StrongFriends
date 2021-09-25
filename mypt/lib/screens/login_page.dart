import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypt/components/custom_textfield_form.dart';
import 'package:mypt/screens/home_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:mypt/theme.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo_mypt.png',
                  height: mediaquery.height * 0.2,
                  width: mediaquery.width * 0.8,
                  fit: BoxFit.contain,
                ),
                _buildGoogleSignInButton(),
                _buildDivider(),
                _userNameTextField(),
                _passwordTextField(),
                _buildLoginButton(mediaquery),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30),
                  child: InkWell(
                    onTap: () {
                      Get.to(HomePage());
                    },
                    child: const Text(
                      'Forgot my password',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                _buildRegisterButton(mediaquery),
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

  Padding _buildGoogleSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Expanded(
        child: SignInButton(
          Buttons.Google,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildLoginButton(Size mediaquery) {
    return Container(
      width: mediaquery.width,
      child: OutlinedButton(
        onPressed: () {
          _formKey.currentState!.validate();
          _userNameTextController.clear();
          _passwordTextController.clear();
          // Get.to(HomePage());
        },
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          backgroundColor: kmintColor,
          side: const BorderSide(width: 2, color: Colors.black),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), side: BorderSide.none),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 20),
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
