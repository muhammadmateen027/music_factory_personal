
import 'package:flutter/material.dart';
import 'package:music_factory/model/model.dart' as art;
import 'package:music_factory/routes/routes.dart';

class AlbumListItem extends StatelessWidget {
  AlbumListItem({Key? key, required this.album}) : super(key: key);

  final art.Album album;

  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    Widget image = const FlutterLogo();
    if (album.image!.isNotEmpty) {
      if (album.image![2].text!.isNotEmpty) {
        image = Image.network(album.image![1].text!);
      }
    }

    return ListTile(
      onTap: () {
        navigationService.pushNamed(RoutesName.albumDetail, arguments: album);
      },
      title: Text(album.name!),
      subtitle: Text(album.artist!.name!),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Center(
          child: image,
        )
      ),
    );
  }
}
