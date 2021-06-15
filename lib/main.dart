import 'dart:convert';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/material.dart';
import 'package:suche_app/router.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'model/user.dart';

void main() {
  //Driver de Test
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  // Inicialização do secure storage
  final SecureStorage secureStorage = SecureStorage();
  String user = '';

  // Obtem os dados do usuário para a primeira tela verificar o login
  secureStorage
      .readSecureData('user')
      .then((value) => value != null ? user = value : user = '')
      .whenComplete(() {
    runApp(
      MyApp(
        user: user,
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final String user;

  const MyApp({
    required this.user,
    Key? key,
  }) : super(key: key);

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
        primarySwatch:
            CustomColors().createMaterialColor(CustomColors.colorOrangePrimary),
      ),
      //Se o usuário estiver logado é redirecionado para home, senão, para o login
      initialRoute: user.isNotEmpty ? homeRoute : loginRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        if (initialRouteName == homeRoute) {
          return [
            RouteGenerator.generateRoute(
              RouteSettings(
                name: homeRoute,
                arguments: User.fromJson(
                  jsonDecode(user),
                ),
              ),
            )
          ];
        } else {
          return [
            RouteGenerator.generateRoute(
              RouteSettings(name: loginRoute),
            )
          ];
        }
      },
      onGenerateRoute: RouteGenerator.generateRoute,

      // home: LoginPage(),
    );
  }
}
