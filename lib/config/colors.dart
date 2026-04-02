import 'package:flutter/material.dart';

class ColorPallete {
  static const Color primaryColor = Color(0xff1865F3);

  static const Color textPrimary = Color(0xff3B3B3B);
}

extension ColorExt on Color {
  Color setOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}
