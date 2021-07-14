import 'package:flutter/material.dart';
import 'package:music_factory/music_factory/music_factory.dart';

import 'routes_name.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    switch (setting.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case RoutesName.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Not available'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 42),
            child: Text(
              'You requested page is not available at the moment.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
