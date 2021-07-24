import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart' as alb;
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
              BlocBuilder<AlbumsBloc, AlbumsState>(
                builder: (_, state) {
                  if (state is AlbumDetailLoaded) {
                    return AlbumDetailAction(
                      onPressed: () {
                        context.read<AlbumsBloc>().add(SaveDeleteAlbumEvent());
                      },
                      isAlbumExist: state.albumExists,
                    );
                  }

                  return const SizedBox();
                },
              )
            ],
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: BlocBuilder<AlbumsBloc, AlbumsState>(
          buildWhen: (pre, curr) {
            if (curr is AlbumsLoading) {
              return true;
            }
            if (curr is AlbumDetailLoaded) {
              return true;
            }
            return false;
          },
          builder: (_, state) {
            if (state is AlbumDetailLoaded) {
              return ListView(
                children: [
                  const SizedBox(height: 8),
                  AlbumInfoView(albumData: state.albumData),
                  const SizedBox(height: 16),
                  TagsView(albumData: state.albumData),
                  DescriptionView(albumData: state.albumData),
                  TracksView(albumData: state.albumData),
                  const SizedBox(height: 16),
                ],
              );
            }

            return const SizedBox();
          },
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
