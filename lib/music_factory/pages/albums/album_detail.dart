import 'package:flutter/material.dart';
import 'package:music_factory/model/model.dart' as art;

class AlbumDetail extends StatelessWidget {
  const AlbumDetail({Key? key, required this.album}) : super(key: key);

  final art.Album album;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  Container(
                    alignment: Alignment.center,
                    child: album.image![3].text!.isEmpty
                        ? const FlutterLogo(size: 200)
                        : Image.network(album.image![3].text!),
                  ),
                  const SizedBox(height: 30),
                  Text(album.name!, style: theme.textTheme.headline6),
                  Text(album.artist!.name!, style: theme.textTheme.bodyText1),
                  Text(
                    album.playcount!.toString(),
                    style: theme.textTheme.headline4,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
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
