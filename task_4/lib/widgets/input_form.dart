import 'package:flutter/material.dart';

// @override
// extension EmailValidator on String {
//   bool isValidEmail() {
//     return RegExp(
//             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//         .hasMatch(this);
//   }
// }


class InputForm extends StatelessWidget {
  final hintText;
  final prefixIcon;
  final controller;
  final String Function(String) validator;
  final String Function(String) onSaved;
  final bool obscureText;
  InputForm({this.hintText, this.prefixIcon, this.controller, this.validator, this.onSaved, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(3, 5),
              color: Colors.grey,
            )
          ]),
      child: TextFormField(
        validator: this.validator,
        controller: this.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(height: 0, color: Colors.transparent),
          hintText: hintText,
          hintStyle: TextStyle(height: 1.4, fontSize: 14),
          prefixIcon: prefixIcon,
        ),
        onSaved: this.onSaved,
        obscureText: this.obscureText,
        cursorHeight: 20,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
