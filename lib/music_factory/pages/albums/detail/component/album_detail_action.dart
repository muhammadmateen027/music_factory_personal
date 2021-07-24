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
    Icon? icon = const Icon(Icons.save, color: Colors.white);
    if (isAlbumExist) {
      icon = const Icon(
        Icons.delete,
        color: Colors.red,
      );
    }

    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
