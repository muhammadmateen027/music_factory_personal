import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (_, state) {
        return Center(
          child: OutlinedButton.icon(
            onPressed: () {
              print('--------1-----------');
              context.read<DashboardBloc>().add(SaveAlbum(album));
              print('--------2-----------');
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        );
      },
    );
  }
}
