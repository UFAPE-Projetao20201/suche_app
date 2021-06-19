import 'package:flutter/material.dart';

class CustomColors {

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // Laranja -> FF7200
  static Color colorOrangePrimary = Color(0xFFFF7200);

  static Color colorOrangeSecondary = Color(0xff804515);

  static Color colorLightGray = Color(0xFFF1F1F1);

  static Color colorMediumGray = Color(0xFFDFDFDF);

  static Color colorDarkGray = Color(0xFFADADAD);

  static MaterialColor orangePrimary = const MaterialColor(
    0xFFFF7200,
    const {
      50: const Color(0xffffb173),
      100: const Color(0xffffaa66),
      200: const Color(0xffff9c4d),
      300: const Color(0xffff8e33),
      400: const Color(0xffff8019),
      500: const Color(0xffff7200),
      600: const Color(0xffe56700),
      700: const Color(0xffcc5b00),
      800: const Color(0xffb25000),
      900: const Color(0xff994400),
    },
  );
}