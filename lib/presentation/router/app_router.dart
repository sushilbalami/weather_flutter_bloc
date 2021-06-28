import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_bloc/presentation/screens/home_screen.dart';
import 'package:weather_app_bloc/presentation/screens/search_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case '/search':
        return MaterialPageRoute(
          builder: (_) => Search(),
        );
      // case '/second':
      //   return MaterialPageRoute(
      //     builder: (_) => SecondScreen(),
      //   );
      // case '/third':
      //   return MaterialPageRoute(
      //     builder: (_) => ThirdScreen(),
      //   );
      // case '/settings':
      //   return MaterialPageRoute(
      //     builder: (_) => Settings(),
      // );
      default:
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
    }
  }

  void dispose() {
    // _counterCubit.close();
  }
}
