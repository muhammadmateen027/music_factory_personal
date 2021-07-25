import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_repository/repository.dart';
import 'package:storage/storage.dart';

import 'component/album_list_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Music factory'),
          actions: [
            IconButton(
              onPressed: () {
                navigationService.pushNamed(RoutesName.searchPage);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<AlbumData>(albumBoxName).listenable(),
          builder: (context, Box<AlbumData> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text('No album found'),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                return AlbumListItem(albumData: box.getAt(index)!);
              },
            );
          },
        ),
      ),
    );
  }
}
