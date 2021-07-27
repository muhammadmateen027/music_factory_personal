import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/global/global.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class AppbarImageView extends StatelessWidget {
  const AppbarImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                return SizedBox(
                  height: 350,
                  width: double.maxFinite,
                  child: ImageView(imageUrl: state.albumData.image![2].text!),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          // Container(
          //   color: Colors.grey.withOpacity(0.4),
          // )
        ],
      ),
    );
  }
}
