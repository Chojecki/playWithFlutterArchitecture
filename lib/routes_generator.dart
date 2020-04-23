import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_horses/screens/add_horse_screen.dart';
import 'package:my_horses/screens/home_screen.dart';
import 'package:my_horses/screens/horse_detail_screen.dart';
import 'package:my_horses/screens/login_screen.dart';
import 'package:my_horses/screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case '/splash':
        return MaterialPageRoute(
            builder: (_) => SplashScreen(), settings: settings);
      case '/addHorse':
        return MaterialPageRoute(
            builder: (_) => AddHorseScreen(), settings: settings);
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      case '/horseDetail':
        return MaterialPageRoute(
            builder: (_) => HorseDetailScreen(
                  horse: args,
                ),
            settings: settings);

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
