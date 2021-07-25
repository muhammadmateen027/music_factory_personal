import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/music_factory/pages/albums/albums.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_repository/repository.dart';

import 'routes_name.dart';
import 'transition_animation/transition_animation.dart';

class RouteGenerator {
  RouteGenerator(this.musicService);

  final MusicService musicService;

  Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    switch (setting.name) {
      case RoutesName.initial:
        return PageTransition.slideUpRoute(const DashboardPage());
      case RoutesName.searchPage:
        Widget page = BlocProvider<ArtistBloc>(
          create: (_) => ArtistBloc(musicService: musicService),
          child: SearchArtistPage(),
        );
        return PageTransition.slideUpRoute(page);

      case RoutesName.albumsPage:
        Widget page = TopAlbumsPage(artist: args as Artist);
        return PageTransition.slideUpRoute(page);

      case RoutesName.albumDetail:
        return PageTransition.scale(
          AlbumDetailPage(albumDetailModel: args as AlbumDetailModel),
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
