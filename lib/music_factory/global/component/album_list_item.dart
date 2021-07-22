import 'package:flutter/material.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/routes/routes.dart';

import '../widget/widget.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({Key? key, required this.album}) : super(key: key);
  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        navigationService.pushNamed(
          RoutesName.albumDetail,
          arguments: album,
        );
      },
      title: TileTextView(title: album.name!),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Center(child: ImageView(imageUrl: album.image![1].text)),
      ),
    );
  }
}
