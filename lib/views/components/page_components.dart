import 'package:flutter/material.dart';
import 'package:suche_app/util/custom_colors.dart';

class PageComponents {
  static Container buildBackgroundContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors.orangePrimary.shade200,
            CustomColors.orangePrimary.shade300,
            CustomColors.orangePrimary.shade400,
            CustomColors.orangePrimary.shade600,
          ],
          stops: [0.1, 0.4, 0.7, 0.99],
        ),
      ),
    );
  }
}