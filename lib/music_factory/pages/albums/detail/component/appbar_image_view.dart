import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/global/global.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_repository/repository.dart';

import 'component.dart';

class AppbarImageView extends StatelessWidget {
  const AppbarImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: double.maxFinite,
      child: Stack(
        children: [
          BlocBuilder<AlbumsBloc, AlbumsState>(
            buildWhen: (pre, curr) {
              if (curr is AlbumsLoading) {
                return true;
              }
              if (curr is AlbumDetailLoaded) {
                return true;
              }
              return false;
            },
            builder: (_, state) {
              if (state is AlbumsLoading) {
                return const SizedBox(
                  height: 350,
                  width: double.maxFinite,
                ).getShimmerEffect();
              }
              if (state is AlbumDetailLoaded) {
                return orientation == Orientation.portrait
                    ? _buildPortrait(state.albumData)
                    : _buildLandscape(state.albumData);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLandscape(AlbumData albumData) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: ImageView(imageUrl: albumData.image![2].text!)),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                AlbumInfoView(albumData: albumData),
                const SizedBox(height: 16),
                TracksView(albumData: albumData),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortrait(AlbumData albumData) {
    return SizedBox(
      height: 350,
      width: double.maxFinite,
      child: ImageView(imageUrl: albumData.image![2].text!),
    );
  }
}
