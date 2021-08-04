import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_factory/l10n/l10n.dart';

import '../../global/global.dart';
import 'component/component.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(l10n.appName),
        actions: [
          IconButton(
            onPressed: () {
              navigationService.pushNamed(RoutesName.searchPage);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (_, state) {
          if (state is AlbumsLoaded) {
            return AlbumsGridView(albums: state.albums);
          }
          return Center(
            child: Text(l10n.albumNotFound),
          );
        },
      ),
    ).addSafeArea(backgroundColor: Theme.of(context).primaryColor);
  }
}
