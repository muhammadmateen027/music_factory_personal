import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/global/global.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class AppbarImageView extends StatelessWidget {
  AppbarImageView({Key? key}) : super(key: key);
  var imageUrl =
      'https://scontent.fkul15-1.fna.fbcdn.net/v/t1.6435-9/133578332_3508428369239793_4754740507169319985_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=nKVj5PBpri8AX-cTAt1&_nc_ht=scontent.fkul15-1.fna&oh=13ede5164a6fa849ccea03996a1685ac&oe=60FE09BB';

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      ),
    );
  }
}
