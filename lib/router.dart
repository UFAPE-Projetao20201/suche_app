// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/views/eventsPages/registerEventPage/register_event_page.dart';
import 'package:suche_app/views/homePage/home_page.dart';
import 'package:suche_app/views/loginPage/login_page.dart';
import 'package:suche_app/views/profilePage/profile_page.dart';
import 'package:suche_app/views/registerUserPage/register_user_page.dart';
import 'model/user.dart';
import 'views/eventsPages/listMyEventsPage/listMyEventsPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case homeRoute:
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => HomePage(
              user: args,
            ),
          );
        }
        return _errorRoute();
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerUserRoute:
        return MaterialPageRoute(builder: (_) => RegisterUserPage());
      case myPastEventEventsRoute:
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => ListMyEventsPage(user: args,),
          );
        }
        return _errorRoute();
      case perfilRoute:
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              user: args,
            ),
          );
        }
        return _errorRoute();
      case registerEventRoute:
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => RegisterEventPage(
              user: args,
            ),
          );
        }else{
        return _errorRoute ();
    }
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
