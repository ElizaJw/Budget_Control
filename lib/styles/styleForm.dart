import 'package:flutter/material.dart';

class StyleForm {
  StyleInput(
    String label,
    String hint,
    Icon icono,
  ) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: icono,
      hintText: hint,
      labelText: label,
    );
  }

  StyleTitle(String titlePage) {
    return Text(
      titlePage,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.blue, fontSize: 20.0, fontStyle: FontStyle.normal),
    );
  }

  SizeSpace(double size) {
    return SizedBox(
      height: 20.0,
    );
  }
}
