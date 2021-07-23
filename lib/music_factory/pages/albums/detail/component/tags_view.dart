import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class TagsView extends StatelessWidget {
  const TagsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      buildWhen: (pre, curr) {
        if (curr is AlbumDetailLoaded) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        if (state is AlbumDetailLoaded) {
          log((state.albumData.tags!.toJson().toString()).toString());
          if (state.albumData.tags == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: dynamicChips(state.albumData.tags!.tag!),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget dynamicChips(List<Tag> mList) {
    return Wrap(
      key: Key(mList.length.toString()),
      spacing: 6.0,
      children: List<Widget>.generate(mList.length, (int index) {
        return ChoiceChip(
          label: Text(mList[index].name!),
          selected: true,
          onSelected: (value) {},
        );
      }),
    );
  }
}
