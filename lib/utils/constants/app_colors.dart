import 'package:flutter/material.dart';

class AppColors {
  //! Colors
  static const Color primaryColor1 = Color.fromRGBO(14, 51, 243, 1);
  static const Color primaryColor2 = Color.fromRGBO(47, 218, 255, 1);
  static const Color colorWhite = Colors.white;
  static Color coloRred = Colors.red;
  static Color colorGrey = const Color.fromARGB(255, 229, 226, 226);
  static Color colorsGreen = Colors.green;
  static Color colorsBlack = Colors.black;
  static Color colorBlue = Colors.blue;
  static Color colorGreyMain = Colors.grey;
  //! Gradients
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [
      Color.fromRGBO(47, 218, 255, 1), // rgba(47, 218, 255, 1)
      Color.fromRGBO(14, 51, 243, 1), // rgba(14, 51, 243, 1)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
