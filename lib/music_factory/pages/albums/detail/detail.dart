import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart' as alb;
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/base_page/base_page.dart';

import '../bloc/albums_bloc.dart';
import 'component/component.dart';

class AlbumDetailPage extends BasePage {
  AlbumDetailPage({Key? key, required this.album}) : super(key: key);
  final alb.Album album;

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends BaseState<AlbumDetailPage> with BasicPage {
  late ThemeData theme;
  final double expandedHeight = 200;

  @override
  void initState() {
    context.read<AlbumsBloc>().add(LoadAlbumDetail(widget.album));
    super.initState();
  }

  late String label;
  late AlbumData albumData;

  @override
  Widget body(BuildContext context) {
    theme = Theme.of(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.album.artist!.name!),
              background: AppbarImageView(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AlbumsBloc>().add(SaveAlbumDetailEvent());
                },
                icon: const Icon(Icons.save),
              )
            ],
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            AlbumInfoView(),
            const SizedBox(height: 16),
            const TagsView(),
            const DescriptionView(),
            TracksView(),
          ],
        ),
      ),
    );
  }

  @override
  bool addAppBar() => false;

  @override
  List<Widget>? appBarActions() => [];

  @override
  String screenName() => '';
}
