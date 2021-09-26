import 'package:flutter/material.dart';

class CustomTextFieldForm extends StatelessWidget {
  final String? text;
  final fValidate;
  final TextEditingController? tController;

  CustomTextFieldForm({@required this.text, @required this.fValidate, @required this.tController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tController,
      validator: fValidate,
      // maxLength: 25,
      obscureText: text == 'Password' || text == 'password' ? true : false,
      decoration: InputDecoration(
        hintText: 'Enter $text',
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
