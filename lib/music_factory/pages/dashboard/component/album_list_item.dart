import 'package:flutter/material.dart';
import 'package:music_factory/music_factory/global/widget/image_view.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_repository/model/album_detail/album.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({Key? key, required this.albumData}) : super(key: key);
  final AlbumData albumData;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ImageView(
                      imageUrl: albumData.image![2].text!,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 6),
                    Text(albumData.name!),
                    const SizedBox(width: 6),
                    Text(
                      (albumData.wiki == null) ? '' : albumData.wiki!.summary!,
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
