import 'package:flutter/material.dart';
import 'package:suche_app/router.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/views/homePage/homePage.dart';
import 'package:suche_app/views/loginPage/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loginRoute,
      onGenerateRoute: RouteGenerator.generateRoute,

      // home: LoginPage(),
    );
  }
}