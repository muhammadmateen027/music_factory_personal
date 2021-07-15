import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/repository/repository.dart';

import 'routes_name.dart';

class RouteGenerator {
  RouteGenerator(this.musicService);

  final MusicService musicService;

  Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    switch (setting.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case RoutesName.searchPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SearchArtistBloc>(
            create: (_) => SearchArtistBloc(musicService: musicService),
            child: const SearchArtistPage(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not available')),
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
