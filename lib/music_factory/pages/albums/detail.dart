import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:music_factory/model/model.dart';
import 'package:music_factory/music_factory/base_page/base_page.dart';
import 'package:music_factory/music_factory/global/global.dart';

import 'bloc/albums_bloc.dart';

class AlbumDetailPage extends BasePage {
  AlbumDetailPage({Key? key, required this.album}) : super(key: key);
  final Album album;

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


  @override
  Widget body(BuildContext context) {
    theme = Theme.of(context);

    return NestedScrollView(
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: expandedHeight,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: TileTextView(
                title: widget.album.artist!.name,
                textStyle: theme.textTheme.headline6,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ImageView(imageUrl: imageUrl),
                  Container(
                    color: Colors.grey.withOpacity(0.4),
                  )
                ],
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: widget.album.name,
                style: theme.textTheme.headline6,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => print('click'),
              ),
            ),
            const SizedBox(height: 16),
            const LabelWithValueView(
              label: 'Artist',
              value: 'Atif Aslam',
            ),
            const SizedBox(height: 8),
            LabelWithValueView(
              label: 'Url',
              value: widget.album.url!,
            ),
            const SizedBox(height: 8),
            LabelWithValueView(
              label: 'Total play count',
              value: widget.album.playcount.toString(),
            ),
            dynamicChips([
              'pop',
              'dance',
              '90s',
              '1998',
              'cher',
              'pop',
              'dance',
              '90s',
              '1998',
              'cher'
            ]),
            _description(),
            _getTracks(),
          ],
        ),
      ),
    );
  }

  Widget _getTracks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tracks', style: theme.textTheme.headline6),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          itemCount: 6,
          separatorBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            );
          },
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('Believe'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWithValueView(
                    label: 'Duration',
                    value: index.toString(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'https://www.last.fm/music/Cher/Believe/Believe',
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  dynamicChips(List<String> mList) {
    List list = mList;
    return Wrap(
      spacing: 6.0,
      children: List<Widget>.generate(list.length, (int index) {
        return ChoiceChip(
          label: Text(list[index]),
          selected: true,
          onSelected: (value) {},
        );
      }),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Description',
              style: theme.textTheme.headline6,
            ),
            Text(
              '03 Mar 2010, 16:48',
              style: theme.textTheme.caption,
            ),
          ],
        ),
        Html(
            data: """<p>
   Believe is the twenty-third studio album by American singer-actress Cher, released on November 10, 1998 by Warner Bros. Records. The RIAA certified it Quadruple Platinum on December 23, 1999, recognizing four million shipments in the United States; Worldwide, the album has sold more than 20 million copies, making it the biggest-selling album of her career. In 1999 the album received three Grammy Awards nominations including \"Record of the Year\", \"Best Pop Album\" and winning \"Best Dance Recording\" for the single \"Believe\". It was released by Warner Bros. Records at the end of 1998. The album was executive produced by Rob <a href=\"https://www.last.fm/music/Cher/Believe\">Read more on Last.fm</a>
  </p>""",
            onLinkTap: (String? url, RenderContext context,
                Map<String, String> attributes, element) {
              log(url!);
              //open URL in webview, or launch URL in browser, or any other logic here
            }),
      ],
    );
  }

  @override
  bool addAppBar() => false;

  @override
  List<Widget>? appBarActions() => [];

  @override
  String screenName() => '';
}
