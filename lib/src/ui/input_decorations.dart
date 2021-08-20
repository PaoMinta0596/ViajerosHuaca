import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {String hintText, String labelText, IconData prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff57BC90)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff57BC90), width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color(0xff57BC90))
            : null);
  }
}
