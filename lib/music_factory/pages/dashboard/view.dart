import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Music factory'),
            actions: [
              IconButton(
                onPressed: () {
                  navigationService.pushNamed(RoutesName.searchPage);
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  context.read<DashboardBloc>().add(DeleteAlbums());
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  context.read<DashboardBloc>().add(LoadAlbums());
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (pre, curr) {
              if (curr is AlbumLoaded) {
                return true;
              }
              if (curr is EmptyAlbums) {
                return true;
              }
              return false;
            },
            builder: (_, state) {
              if (state is AlbumLoaded) {
                Widget image = const FlutterLogo();

                return ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (_, index) {
                    if (state.albums[index].images!.isNotEmpty) {
                      image = Image.memory(
                        state.albums[index].images![0].text!,
                      );
                    }

                    return ListTile(
                      onTap: () {
                        navigationService.pushNamed(
                          RoutesName.albumDetail,
                          arguments: state.albums[index],
                        );
                      },
                      title: Text(state.albums[index].name!),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(child: image),
                      ),
                    );
                  },
                );
              }

              if (state is EmptyAlbums) {
                return const Center(
                  child: Text('No album available'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    context.read<DashboardBloc>().add(LoadAlbums());
    super.initState();
  }
}
