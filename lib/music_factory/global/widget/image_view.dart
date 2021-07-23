import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, message, state) {
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
      },
      fit: BoxFit.fitWidth,
      imageUrl: imageUrl,
    );
  }
}
