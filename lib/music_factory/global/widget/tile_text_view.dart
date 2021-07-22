import 'package:flutter/material.dart';

class TileTextView extends StatelessWidget {
  const TileTextView({
    Key? key,
    required this.title,
    this.textStyle = const TextStyle(),
  }) : super(key: key);
  final String? title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return Container();
    }

    return Text(title!, style: textStyle);
  }
}
