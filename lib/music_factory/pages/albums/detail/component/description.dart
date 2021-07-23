import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AlbumsBloc, AlbumsState>(
      buildWhen: (pre, curr) {
        if (curr is AlbumDetailLoaded) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        if (state is AlbumDetailLoaded) {
          if (state.albumData.wiki == null) {
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
                      'Description',
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      state.albumData.wiki!.published!,
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
                _descriptionView(state.albumData.wiki!.summary!)
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
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
