import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/albums_bloc.dart';
import 'component/component.dart';

class TopAlbumsPage extends StatefulWidget {
  const TopAlbumsPage({Key? key, required this.artist}) : super(key: key);
  final Artist artist;

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<TopAlbumsPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    context.read<AlbumsBloc>().add(LoadTopTags(widget.artist));
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.artist.name!),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return BlocConsumer<AlbumsBloc, AlbumsState>(
      listener: (_, state) {
        // if (state is SearchArtistFailure) {
        //   _refreshController.loadComplete();
        // }
        // if (state is SearchArtistInitial) {
        //   _refreshController.resetNoData();
        // }
        // if (state is ArtistsListEnds) {
        //   _refreshController.loadComplete();
        //   return;
        // }
        // if (state is ArtistsLoadedState) {
        //   if (state.artists!.isEmpty) {
        //     _refreshController.resetNoData();
        //   }
        //
        // }
      },
      // buildWhen: (pre, curr) {
      //   if (curr is SearchArtistInitial) {
      //     return true;
      //   }
      //   if(curr is ArtistsLoadedState) {
      //     if (curr.reachedMaximum) {
      //       _refreshController.loadComplete();
      //       return false;
      //     }
      //     return true;
      //   }
      //   return false;
      // },
      builder: (context, state) {
        if (state is TopTagsLoaded) {
          _refreshController.loadComplete();
          return _getList(state);
        }

        return const Center();
      },
    );
  }

  Widget _getList(TopTagsLoaded state) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: false,
      controller: _refreshController,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return AlbumListItem(
            album: state.topAlbumsModel!.topalbums!.album![index],
          );
        },
        itemCount: state.topAlbumsModel!.topalbums!.album!.length,
      ),
    );
  }
}
