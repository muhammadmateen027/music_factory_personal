import 'package:flutter/material.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_repository/model/album_detail/album.dart';
import 'package:music_factory/music_factory/global/extension/extension.dart';

class AlbumGridItem extends StatelessWidget {
  const AlbumGridItem({Key? key, required this.albumData}) : super(key: key);
  final AlbumData albumData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        navigationService.pushNamed(
          RoutesName.albumDetail,
          arguments: AlbumDetailModel(
            albumName: albumData.name,
            artistName: albumData.artistName,
            mbid: albumData.mbid,
            url: albumData.url,
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(albumData.image![2].text!),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Wrap(
                children: [
                  Text(
                    albumData.name!,
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    (albumData.wiki == null) ? '' : albumData.wiki!.summary!,
                    style: theme.textTheme.caption!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ).bottomCircularBorder(color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }
}
