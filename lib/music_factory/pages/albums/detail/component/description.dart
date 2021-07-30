import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:music_repository/repository.dart';
import 'package:music_factory/l10n/l10n.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({Key? key, required this.albumData}) : super(key: key);
  final AlbumData albumData;
  
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    if (albumData.wiki == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                l10n.descriptionLabel,
                style: theme.textTheme.headline6,
              ),
              Text(
                albumData.wiki!.published!,
                style: theme.textTheme.caption,
              ),
            ],
          ),
          _descriptionView(albumData.wiki!.summary!)
        ],
      ),
    );
  }

  Widget _descriptionView(String summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Html(
            data: summary,
            onLinkTap: (String? url, RenderContext context,
                Map<String, String> attributes, element) {
              //open URL in webview, or launch URL in browser, or any other logic here
            }),
      ],
    );
  }
}
