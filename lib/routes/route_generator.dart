import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/music_factory/pages/albums/albums.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_repository/repository.dart';
import 'package:music_factory/l10n/l10n.dart';

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
        return PageTransition.slideUpRoute(
          AlbumDetailPage(albumDetailModel: args as AlbumDetailModel),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      final l10n = _.l10n;
      return Scaffold(
        appBar: AppBar(title: Text(l10n.pageNotAvailableLabel)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Text(
              l10n.pageNotAvailableDescription,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
