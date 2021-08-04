import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/base_page/base_page.dart';
import 'package:music_factory/music_factory/pages/albums/model/album_detail_model.dart';
import 'package:music_repository/repository.dart';

import '../bloc/albums_bloc.dart';
import 'component/component.dart';

class AlbumDetailPage extends BasePage {
  const AlbumDetailPage({Key? key, required this.albumDetailModel})
      : super(key: key);
  final AlbumDetailModel albumDetailModel;

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends BaseState<AlbumDetailPage> with BasicPage {
  late ThemeData theme;
  final double expandedHeight = 200;

  @override
  void initState() {
    context.read<AlbumsBloc>().add(LoadAlbumDetail(widget.albumDetailModel));
    super.initState();
  }

  late String label;

  @override
  Widget body(BuildContext context) {
    theme = Theme.of(context);
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height / 1.2;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight:
                orientation == Orientation.portrait ? 350.0 : height,
            floating: false,
            pinned: true,
            backgroundColor: theme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: orientation == Orientation.portrait ? true : false,
              title: Text(widget.albumDetailModel.artistName!),
              background: const AppbarImageView(),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: BlocBuilder<AlbumsBloc, AlbumsState>(
          buildWhen: (pre, curr) {
            if (curr is EmptyAlbum) {
              return true;
            }
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
              return orientation == Orientation.portrait
                  ? _buildPortrait(state.albumData)
                  : _buildLandscape(state.albumData);
            }

            if (state is EmptyAlbum) {
              return const Center(
                child: Text('Album detail is not available.'),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLandscape(AlbumData albumData) {
    return ListView(
      children: [
        TagsView(albumData: albumData),
        DescriptionView(albumData: albumData),
      ],
    );
  }

  Widget _buildPortrait(AlbumData albumData) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        AlbumInfoView(albumData: albumData),
        const SizedBox(height: 16),
        TagsView(albumData: albumData),
        DescriptionView(albumData: albumData),
        TracksView(albumData: albumData),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  bool addAppBar() => false;

  @override
  List<Widget>? appBarActions() => [];

  @override
  String screenName() => '';
}
