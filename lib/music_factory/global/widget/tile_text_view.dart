import 'package:flutter/material.dart';

class TileTextView extends StatelessWidget {
  const TileTextView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
