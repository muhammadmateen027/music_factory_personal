import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/music_factory.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      buildWhen: (pre, curr) {
        if (curr is AlbumDetailLoaded) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        // if (state is AlbumDetailLoaded) {
        //   return Center(
        //     child: MaterialButton(
        //       color: Theme.of(context).errorColor,
        //       onPressed: () {
        //         context.read<DashboardBloc>().add(DeleteItem(album));
        //
        //       },
        //       textColor: Theme.of(context).colorScheme.background,
        //       textTheme: Theme.of(context).buttonTheme.textTheme,
        //       child: const Text(
        //         'Delete',
        //       ),
        //     ),
        //   );
        // }

        if (state is AlbumDetailLoaded) {
          return Center(
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<AlbumsBloc>().add(SaveAlbumDetailEvent());
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
