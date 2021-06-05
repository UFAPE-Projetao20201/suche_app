import 'package:flutter/material.dart';
import 'package:suche_app/router.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors().createMaterialColor(CustomColors.colorOrangePrimary),
      ),
      initialRoute: loginRoute,
      onGenerateRoute: RouteGenerator.generateRoute,

      // home: LoginPage(),
    );
  }
}