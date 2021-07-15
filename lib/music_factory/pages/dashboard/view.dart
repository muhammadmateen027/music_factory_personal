import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(LoadAlbums());

    return Material(
      child: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              navigationService.pushNamed(RoutesName.searchPage);
            },
            child: const FlutterLogo(
              size: 100,
              style: FlutterLogoStyle.stacked,
            ),
          ),
        ),
      ),
    );
  }
}
