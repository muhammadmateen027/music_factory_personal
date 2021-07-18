import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart' as art;
import 'package:music_factory/music_factory/music_factory.dart';

import 'component/component.dart';

class AlbumDetail extends StatelessWidget {
  const AlbumDetail({Key? key, required this.album}) : super(key: key);

  final art.Album album;

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(LoadAlbumDetail(album));

    final theme = Theme.of(context);
    return Material(
      color: Colors.green,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(album.artist!.name!),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<DashboardBloc, DashboardState>(
                    buildWhen: (pre, curr) {
                      if (curr is AlbumDetailLoaded) {
                        return true;
                      }
                      if (pre is AlbumDetailLoaded) {
                        return true;
                      }
                      return true;
                    },
                    builder: (_, state) {
                      if (state is AlbumDetailLoaded) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: state.album.images![3].text!.isEmpty
                                  ? const FlutterLogo(size: 200)
                                  : Image.network(state.album.images![3].text!),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              state.album.name!,
                              style: theme.textTheme.headline6,
                            ),
                            Text(
                              state.album.artist!.name!,
                              style: theme.textTheme.bodyText1,
                            ),
                            Text(
                              state.album.playcount!.toString(),
                              style: theme.textTheme.headline4,
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  BlocProvider.value(
                    value: context.read<DashboardBloc>(),
                    child: ActionButton(album: album),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
