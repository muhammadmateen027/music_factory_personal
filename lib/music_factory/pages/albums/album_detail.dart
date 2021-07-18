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
    Widget image = const FlutterLogo(size: 200);

    if (album.images!.isNotEmpty) {
      if (album.images![0].text!.isNotEmpty) {
        if (album.images![0].text!.runtimeType == String) {
          image = Image.network(album.images![3].text!);
        } else {
          image = Image.memory(
            album.images![0].text!,
            width: double.maxFinite,
            height: 200,
            scale: 0.1,
          );
        }
      }
    }


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
                        child: image,
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
