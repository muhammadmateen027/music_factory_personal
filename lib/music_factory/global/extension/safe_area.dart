import 'package:flutter/material.dart';
// Will use this this SafeArea for each page

extension AppSafeArea on Widget {
  Material addSafeArea({Color backgroundColor = Colors.white}) {
    return Material(
      color: backgroundColor,
      child: SafeArea(child: this),
    );
  }
}
