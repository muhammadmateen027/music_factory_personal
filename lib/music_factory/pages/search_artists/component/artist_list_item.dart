import 'package:flutter/material.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_repository/repository.dart' hide Image;

class ArtistListItem extends StatelessWidget {
  const ArtistListItem({Key? key, required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: () {
          navigationService.pushNamed(
            RoutesName.albumsPage,
            arguments: artist,
          );
        },
        title: Text(artist.name!),
        isThreeLine: true,
        subtitle: Text(artist.listeners!),
        dense: true,
        leading: SizedBox(
          width: 50,
          height: 50,
          child: artist.image![1].text!.isEmpty
              ? const FlutterLogo()
              : Image.network(artist.image![1].text!),
        ),
      ),
    );
  }
}
