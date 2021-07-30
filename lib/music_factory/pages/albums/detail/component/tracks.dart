import 'package:flutter/material.dart';
import 'package:music_factory/music_factory/global/widget/label_with_value.dart';
import 'package:music_repository/repository.dart';
import 'package:music_factory/l10n/l10n.dart';

class TracksView extends StatelessWidget {
  const TracksView({Key? key, required this.albumData}) : super(key: key);
  final AlbumData albumData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    if (albumData.tracks == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.tracksLabel, style: theme.textTheme.headline6),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            itemCount: albumData.tracks!.track!.length,
            separatorBuilder: (_, index) {
              return const Divider(indent: 16, endIndent: 16);
            },
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(albumData.tracks!.track![index].name!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWithValueView(
                      label: l10n.durationLabel,
                      value: albumData.tracks!.track![index].duration
                          .toString(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      albumData.tracks!.track![index].url!,
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
}
