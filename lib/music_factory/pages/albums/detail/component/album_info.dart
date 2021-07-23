import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/global/global.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class AlbumInfoView extends StatelessWidget {
  AlbumInfoView({Key? key}) : super(key: key);

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return SizedBox(
      width: double.maxFinite,
      child: Stack(
        children: [
          BlocBuilder<AlbumsBloc, AlbumsState>(
            buildWhen: (pre, curr) {
              if (curr is AlbumDetailLoaded) {
                return true;
              }
              if (curr is AlbumsLoading) {
                return true;
              }
              return false;
            },
            builder: (_, state) {
              if (state is AlbumsLoading) {
                return _getAlbumInfo(
                  albumName: 'album name',
                  listener: '0',
                  playCount: '0',
                ).getShimmerEffect();
              }
              if (state is AlbumDetailLoaded) {
                return _getAlbumInfo(
                  albumName: state.albumData.name,
                  listener: state.albumData.listeners,
                  playCount: state.albumData.playcount,
                );
              }

              return const SizedBox();
            },
          ),
          Container(color: Colors.grey.withOpacity(0.4))
        ],
      ),
    );
  }

  Widget _getAlbumInfo({
    String? albumName,
    String? listener,
    String? playCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 5,
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: albumName,
                    style: theme.textTheme.headline6,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('click'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [const Icon(Icons.person), Text(listener!)],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.play_circle_outline),
                        Text(playCount!)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
