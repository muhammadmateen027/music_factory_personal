import 'package:flutter/material.dart';

extension BorderExtension on Widget {
  Container bottomCircularBorder({Color color = Colors.white}) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const  BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: this,
    );
  }
}
