import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/base_page/base_page.dart';
import 'package:music_repository/repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/albums_bloc.dart';
import 'component/component.dart';

class TopAlbumsPage extends BasePage {
  TopAlbumsPage({Key? key, required this.artist}) : super(key: key);
  final Artist artist;

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends BaseState<TopAlbumsPage> with BasicPage {

  late RefreshController _refreshController;

  @override
  void initState() {
    context.read<AlbumsBloc>().add(LoadTopAlbums(widget.artist));
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return _getBody();
  }


  Widget _getBody() {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      buildWhen: (pre, curr) {
        if(curr is AlbumsFetched) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is AlbumsFetched) {
          _refreshController.loadComplete();
          return _getList(state);
        }

        return const Center();
      },
    );
  }

  Widget _getList(AlbumsFetched state) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      onLoading: loadRequests,
      controller: _refreshController,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return AlbumListItem(
            album: state.album![index],
          );
        },
        itemCount: state.album!.length,
      ),
    );
  }

  void loadRequests() {
    _refreshController.requestLoading();
    context.read<AlbumsBloc>().add(LoadTopAlbums(widget.artist));
    return;
  }

  @override
  bool addAppBar() => true;

  @override
  List<Widget>? appBarActions() => [];


  @override
  String screenName() => widget.artist.name!;
}
