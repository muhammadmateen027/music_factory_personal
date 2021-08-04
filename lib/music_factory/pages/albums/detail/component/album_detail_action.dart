import 'package:flutter/material.dart';

typedef SaveDeleteAction = void Function();

class AlbumDetailAction extends StatelessWidget {
  const AlbumDetailAction({
    Key? key,
    required this.isAlbumExist,
    required this.onPressed,
  }) : super(key: key);

  final bool isAlbumExist;
  final SaveDeleteAction onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: isAlbumExist
          ? const Icon(Icons.star, color: Colors.orange)
          : const Icon(Icons.star_border, color: Colors.orange),
    );
  }
}
