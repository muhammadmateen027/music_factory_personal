import 'package:cached_network_image/cached_network_image.dart';
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
    context.read<DashboardBloc>().add(LoadButtonState(album));

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
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          imageUrl: album.image![3].text!,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        album.name!,
                        style: theme.textTheme.headline6,
                      ),
                      Text(
                        album.artist!.name!,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                        album.playcount!.toString(),
                        style: theme.textTheme.headline4,
                      ),
                      const SizedBox(height: 40),
                    ],
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
