import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class SearchArtistPage extends StatelessWidget {
  const SearchArtistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SearchArtistBloc>().add(SearchArtists());

    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: BlocBuilder<SearchArtistBloc, SearchArtistState>(
            builder: (_, state) {
              if (state is ArtistsLoaded) {
                return ListView.builder(
                  itemCount: state.artists.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(state.artists[index].name!),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
