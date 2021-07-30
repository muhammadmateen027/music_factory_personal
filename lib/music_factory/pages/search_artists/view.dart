import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:music_factory/l10n/l10n.dart';

import '../../global/global.dart';
import 'component/component.dart';

class SearchArtistPage extends StatefulWidget {
  @override
  _SearchArtistPageState createState() => _SearchArtistPageState();
}

class _SearchArtistPageState extends State<SearchArtistPage> {
  late RefreshController _refreshController;
  late ArtistBloc _artistBloc;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _artistBloc = context.read<ArtistBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(l10n.searchLabel),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: BlocProvider.value(
            value: _artistBloc,
            child: SearchBar(),
          ),
        ),
      ),
      body: _getBody(l10n),
    ).addSafeArea(backgroundColor: Theme.of(context).colorScheme.primary);
  }

  Widget _getBody(AppLocalizations l10n) {
    return BlocConsumer<ArtistBloc, ArtistState>(
      listener: (_, state) {
        if (state is SearchArtistFailure) {
          _refreshController.loadComplete();
        }
        if (state is SearchArtistInitial) {
          _refreshController.resetNoData();
        }
        if (state is ArtistsListEnds) {
          _refreshController.loadComplete();
          return;
        }
        if (state is ArtistsLoadedState) {
          if (state.artists!.isEmpty) {
            _refreshController.resetNoData();
          }

        }
      },
      buildWhen: (pre, curr) {
        if (curr is SearchArtistInitial) {
          return true;
        }
        if(curr is ArtistsLoadedState) {
          if (curr.reachedMaximum) {
            _refreshController.loadComplete();
            return false;
          }
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SearchArtistInitial) {
          return Center(child: Text(l10n.artistNotFoundMessage));
        }

        if (state is ArtistsLoadedState) {
          _refreshController.loadComplete();
          if (state.reachedMaximum) {
            _refreshController.loadNoData();
          }
          return _getList(state);
        }

        return const Center();
      },
    );
  }

  Widget _getList(ArtistsLoadedState state) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: _refreshController,
      onLoading: loadRequests,
      child: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(height: 4),
        itemBuilder: (BuildContext context, int index) {
          return index >= state.artists!.length
              ? BottomLoader()
              : ArtistListItem(artist: state.artists![index]);
        },
        itemCount: state.artists!.length,
      ),
    );
  }


  void loadRequests() {
    _refreshController.requestLoading();
    _artistBloc.add(LoadArtists());
    return;
  }
}
