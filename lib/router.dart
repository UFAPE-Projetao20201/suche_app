import 'package:flutter/material.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/views/homePage/home_page.dart';
import 'package:suche_app/views/loginPage/login_page.dart';
import 'package:suche_app/views/perfilPage/perfil_page.dart';
import 'package:suche_app/views/registerPage/register_event_page.dart';
import 'package:suche_app/views/registerPage/register_promoter_page.dart';
import 'package:suche_app/views/registerPage/register_user_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; // ignore: unused_local_variable

    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerUserRoute:
        return MaterialPageRoute(builder: (_) => RegisterUserPage());
      case perfilRoute:
        return MaterialPageRoute(builder: (_) => PerfilPage());
      case registerPromoterRoute:
        return MaterialPageRoute(builder: (_) => RegisterPromoterPage());
      case registerEventRoute:
        return MaterialPageRoute(builder: (_) => RegisterEventPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
