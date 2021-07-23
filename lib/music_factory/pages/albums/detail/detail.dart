
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_factory/model/model.dart' as alb;
import 'package:music_factory/music_factory/base_page/base_page.dart';

import '../bloc/albums_bloc.dart';
import 'component/component.dart';

class AlbumDetailPage extends BasePage {
  AlbumDetailPage({Key? key, required this.album}) : super(key: key);
  final alb.Album album;

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends BaseState<AlbumDetailPage> with BasicPage {
  late ThemeData theme;
  final double expandedHeight = 200;
  var imageUrl =
      'https://scontent.fkul15-1.fna.fbcdn.net/v/t1.6435-9/133578332_3508428369239793_4754740507169319985_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=nKVj5PBpri8AX-cTAt1&_nc_ht=scontent.fkul15-1.fna&oh=13ede5164a6fa849ccea03996a1685ac&oe=60FE09BB';

  @override
  void initState() {
    context.read<AlbumsBloc>().add(LoadAlbumDetail(widget.album));
    super.initState();
  }
  late String label;


  @override
  Widget body(BuildContext context) {
    theme = Theme.of(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.album.artist!.name!),
                background: AppbarImageView(),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            AlbumInfoView(),
            const SizedBox(height: 16),
            const TagsView(),
            const DescriptionView(),
            TracksView(),
          ],
        ),
      ),
    );
  }



  @override
  bool addAppBar() => false;

  @override
  List<Widget>? appBarActions() => [];

  @override
  String screenName() => '';
}
