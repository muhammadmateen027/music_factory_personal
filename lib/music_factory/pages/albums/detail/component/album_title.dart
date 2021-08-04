import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';

import 'album_detail_action.dart';

class AlbumTitle extends StatelessWidget {
  const AlbumTitle({Key? key, required this.albumName}) : super(key: key);
  final String albumName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: RichText(
            text: TextSpan(
              text: albumName,
              style: theme.textTheme.headline6,
              recognizer: TapGestureRecognizer()..onTap = () => log('click'),
            ),
          ),
        ),
        Flexible(
          child: BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (_, state) {
              if (state is AlbumDetailLoaded) {
                return AlbumDetailAction(
                  onPressed: () {
                    context.read<AlbumsBloc>().add(SaveDeleteAlbumEvent());
                  },
                  isAlbumExist: state.albumExists,
                );
              }

              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
