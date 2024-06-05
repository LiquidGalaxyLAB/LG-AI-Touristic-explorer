import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle googleTextStyle(
    double customFontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
      color: color,
      fontSize: customFontSize,
      fontWeight: fontWeight,
    ),
  );
}

TextStyle googleGradientTextStyle(
  double customFontSize,
  FontWeight fontWeight,
  Color color1,
  Color color2,
) {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
      foreground: Paint()
        ..shader = LinearGradient(
          colors: <Color>[color1, color2],
        ).createShader(Rect.fromLTWH(0.0, 0.0, 800.0, 70.0)),
      fontSize: customFontSize,
      fontWeight: fontWeight,
    ),
  );
}
