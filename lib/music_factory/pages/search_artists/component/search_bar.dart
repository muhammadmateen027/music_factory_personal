import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search_artists.dart';

typedef VoidCallback = void Function();
typedef ValueChanged<T> = void Function(T value);

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, this.onPressed, this.onSubmitted}) : super(key: key);

  final VoidCallback? onPressed;
  final ValueChanged? onSubmitted;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {
            context.read<ArtistBloc>().add(SearchArtists(query: value));
          },
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 14),
            hintText: 'Search here',
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              onPressed: () {
                context.read<ArtistBloc>().add(
                      SearchArtists(query: controller.text),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
