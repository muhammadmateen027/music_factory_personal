import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SafeArea(
        child: Center(
          child: FlutterLogo(
            size: 100,
            style: FlutterLogoStyle.stacked,
          ),
        ),
      ),
    );
  }
}
