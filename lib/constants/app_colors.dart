import 'package:flutter/material.dart';

class AppColors {
  static const Color yellow = Color(0xff22bd6b);
  static const Color dark = Color(0xff202023);
  static const Color white = Color(0xffF7F7F7);
  static Color darkenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);

    // Getting RGB values of the original color
    int red = color.red;
    int green = color.green;
    int blue = color.blue;

    //Calculating new RGB values based on the amount of dark
    red = (red * (1 - amount)).round();
    green = (green * (1 - amount)).round();
    blue = (blue * (1 - amount)).round();

    // Creation and return of the new dark color
    return Color.fromARGB(color.alpha, red, green, blue);
  }
}
