import 'package:flutter/material.dart';
import 'package:music_repository/repository.dart';

import 'album_grid_item.dart';

class AlbumsGridView extends StatelessWidget {
  const AlbumsGridView({Key? key, required this.albums}) : super(key: key);
  final List<AlbumData> albums;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 8),
        itemCount: albums.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return AlbumGridItem(albumData: albums[index]);
        },
      ),
    );
  }
}
