import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(LoadAlbums());

    return Material(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
              if (state is AlbumLoaded) {
                return ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(state.albums[index].name!),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: state.albums[index].image![0].text!.isEmpty
                              ? const FlutterLogo()
                              : Image.network(
                                  json.decode(
                                      state.albums[index].image![0].text!),
                                ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text('No album available'),
              );
            },
          ),
        ),
      ),
    );
  }
}
