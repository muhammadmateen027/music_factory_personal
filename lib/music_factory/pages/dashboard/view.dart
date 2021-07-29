import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';

import '../../global/global.dart';
import 'component/album_list_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Music factory'),
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
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                return AlbumListItem(albumData: state.albums[index]);
              },
            );
          }
          return const Center(
            child: Text('No album found'),
          );
        },
      ),
    ).addSafeArea(backgroundColor: Theme.of(context).primaryColor);
  }
}
