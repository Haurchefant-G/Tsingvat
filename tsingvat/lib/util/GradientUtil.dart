import 'package:flutter/material.dart';
import 'dart:math' as math;

Color _intToColor(int hexNumber) => Color.fromARGB(
    255,
    (hexNumber >> 16) & 0xFF,
    ((hexNumber >> 8) & 0xFF),
    (hexNumber >> 0) & 0xFF);

String _textSubString(String text) {
  if (text == null) return null;

  if (text.length < 6) return null;

  if (text.length == 6) return text;

  return text.substring(1, text.length);
}

Color stringToColor(String hex) =>
    _intToColor(int.parse(_textSubString(hex), radix: 16));

class GradientUtil {
  static LinearGradient _getLinearGradient({
    @required List<Color> colors,
    List<double> stops,
    double opacity = 1.0,
    double angle = 0,
    TileMode tilemode,
  }) {
    if (opacity != 1.0) {
      List<Color> ncolors = [];
      colors.forEach((element) {
        ncolors.add(element.withOpacity(opacity));
      });
      colors = ncolors;
    }
    return LinearGradient(
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
        stops: stops,
        colors: colors,
        tileMode: tilemode != null ? tilemode : TileMode.mirror,
        transform: GradientRotation(math.pi / 180 * angle));
  }

  static LinearGradient warmFlame({
    double opacity = 1.0,
    double angle = 0,
    TileMode tilemode,
  }) =>
      _getLinearGradient(colors: [
        stringToColor("#ff9a9e"),
        stringToColor("#fad0c4"),
        stringToColor("#fad0c4")
      ], stops: [
        0.0,
        0.99,
        1.0
      ], angle: angle, opacity: opacity, tilemode: tilemode);
}
