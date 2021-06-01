import 'package:flutter/material.dart';
import 'package:suche_app/util/custom_colors.dart';

/// This file contains all the routing constants used within the app

const String homeRoute = '/';
const String loginRoute = '/login';
const String registerRoute = '/register';
const String perfilRoute = '/perfil';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kErrorTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,

);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: CustomColors.colorOrangePrimary,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationBackgroundStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      CustomColors.orangePrimary.shade200,
      CustomColors.orangePrimary.shade300,
      CustomColors.orangePrimary.shade400,
      CustomColors.orangePrimary.shade700,
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);