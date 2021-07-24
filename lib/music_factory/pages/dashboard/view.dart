import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/music_factory.dart';
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
          if (box.values.isEmpty)
            return Center(
              child: Text("No contacts"),
            );
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              AlbumData? albumData = box.getAt(index);

              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onLongPress: () {
                    /* ... */
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text(albumData!.name!),
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
