import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/global/widget/image_view.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_factory/routes/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music factory'),
        actions: [
          IconButton(
            onPressed: () {
              navigationService.pushNamed(RoutesName.searchPage);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.read<DashboardBloc>().add(TruncateTable());
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              context.read<DashboardBloc>().add(LoadAlbums());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<AlbumData>(musicAlbumBoxName).listenable(),
        builder: (context, Box<AlbumData> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No contacts"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              AlbumData? albumData = box.getAt(index);

              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    navigationService.pushNamed(
                      RoutesName.albumDetail,
                      arguments: AlbumDetailModel(
                        albumName: albumData!.name,
                        artistName: albumData.artistName,
                        mbid: albumData.mbid,
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
                                imageUrl: albumData!.image![2].text!,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 6),
                              Text(albumData.name!),
                              SizedBox(width: 6),
                              Text(
                                albumData.url!,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Material(
//     color: Theme.of(context).primaryColor,
//     child: SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Music factory'),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 navigationService.pushNamed(RoutesName.searchPage);
//               },
//               icon: const Icon(Icons.search),
//             ),
//             IconButton(
//               onPressed: () {
//                 context.read<DashboardBloc>().add(TruncateTable());
//               },
//               icon: const Icon(Icons.delete),
//             ),
//             IconButton(
//               onPressed: () {
//                 context.read<DashboardBloc>().add(LoadAlbums());
//               },
//               icon: const Icon(Icons.refresh),
//             ),
//           ],
//         ),
//         body: BlocBuilder<DashboardBloc, DashboardState>(
//           buildWhen: (pre, curr) {
//             if (curr is AlbumLoaded) {
//               return true;
//             }
//             if (curr is EmptyAlbums) {
//               return true;
//             }
//             return false;
//           },
//           builder: (_, state) {
//             if (state is AlbumLoaded) {
//               return ListView.builder(
//                 itemCount: state.albums.length,
//                 itemBuilder: (_, index) {
//                   return AlbumListItem(album: state.albums[index]);
//                 },
//               );
//             }
//
//             if (state is EmptyAlbums) {
//               return const Center(
//                 child: Text('No album available'),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }
}
