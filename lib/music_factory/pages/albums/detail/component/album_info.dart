
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_factory/model/model.dart';

class AlbumInfoView extends StatelessWidget {
  AlbumInfoView({Key? key, required this.albumData}) : super(key: key);

  final AlbumData albumData;
  late ThemeData theme;


  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return SizedBox(
      width: double.maxFinite,
      child: Stack(
        children: [
          _getAlbumInfo(
            albumName: albumData.name,
            listener: albumData.listeners,
            playCount: albumData.playcount,
          ),
          Container(color: Colors.grey.withOpacity(0.4))
        ],
      ),
    );
  }

  Widget _getAlbumInfo({
    String? albumName,
    String? listener,
    String? playCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 5,
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: albumName,
                    style: theme.textTheme.headline6,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('click'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [const Icon(Icons.person), Text(listener!)],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.play_circle_outline),
                        Text(playCount!)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
