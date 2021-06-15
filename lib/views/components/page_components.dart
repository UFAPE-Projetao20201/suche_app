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
            CustomColors.orangePrimary.shade50,
            CustomColors.orangePrimary.shade100,
            CustomColors.orangePrimary.shade100,
            CustomColors.orangePrimary.shade200,
          ],
          stops: [0.1, 0.25, 0.65, 0.99],
        ),
      ),
    );
  }
}