import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/global/widget/label_with_value.dart';

import '../../albums.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return BlocBuilder<AlbumsBloc, AlbumsState>(
      buildWhen: (pre, curr) {
        if (curr is AlbumDetailLoaded) {
          return true;
        }
        if (curr is AlbumsLoading) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        if (state is AlbumsLoading) {}
        if (state is AlbumDetailLoaded) {
          if (state.albumData.tracks == null) {
            return const SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tracks', style: theme.textTheme.headline6),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.albumData.tracks!.track!.length,
                  separatorBuilder: (_, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(state.albumData.tracks!.track![index].name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelWithValueView(
                            label: 'Duration',
                            value: state.albumData.tracks!.track![index].duration
                                .toString(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            state.albumData.tracks!.track![index].url!,
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
