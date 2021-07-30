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
    return IconButton(
      onPressed: onPressed,
      icon: isAlbumExist
          ? const Icon(Icons.delete, color: Colors.red)
          : const Icon(Icons.save, color: Colors.white),
    );
  }
}
