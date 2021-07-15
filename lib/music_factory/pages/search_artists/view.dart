import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';

import 'component/component.dart';

class SearchArtistPage extends StatefulWidget {
  @override
  _SearchArtistPageState createState() => _SearchArtistPageState();
}

class _SearchArtistPageState extends State<SearchArtistPage> {
  final _scrollController = ScrollController();
  late SearchArtistBloc _artistBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _artistBloc = context.read<SearchArtistBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: BlocProvider.value(
                value: _artistBloc,
                child: SearchBar(),
              ),
            ),
          ),
          body: _getList(),
        ),
      ),
    );
  }

  Widget _getList() {
    return BlocBuilder<SearchArtistBloc, SearchArtistState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchArtistStatus.failure:
            return GestureDetector(
              onTap: () => _artistBloc.add(const SearchArtists()),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.refresh),
                    Text('failed to fetch artists')
                  ],
                ),
              ),
            );
          case SearchArtistStatus.success:
            if (state.artists.isEmpty) {
              return const Center(child: Text('no artists'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.artists.length
                    ? BottomLoader()
                    : ArtistListItem(artist: state.artists[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.artists.length
                  : state.artists.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center();
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom) {
      _artistBloc.add(
        const SearchArtists(),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
