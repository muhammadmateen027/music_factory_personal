import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search_artists.dart';

typedef VoidCallback = void Function();
typedef ValueChanged<T> = void Function(T value);

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  // final VoidCallback? onPressed;
  // final ValueChanged? onSubmitted;

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
            context.read<SearchArtistBloc>().add(SearchArtists(query: value));
          },
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.only(top: 14),
            hintText: 'Search jobs here',
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              onPressed: () {
                context.read<SearchArtistBloc>().add(
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
