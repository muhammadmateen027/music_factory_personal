import 'package:flutter/material.dart';
import 'package:music_repository/repository.dart';

class TagsView extends StatelessWidget {
  const TagsView({Key? key, required this.albumData}) : super(key: key);
  final AlbumData albumData;
  
  @override
  Widget build(BuildContext context) {
    if (albumData.tags == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: dynamicChips(albumData.tags!.tag!),
    );
  }

  Widget dynamicChips(List<Tag> mList) {
    return Wrap(
      key: Key(mList.length.toString()),
      spacing: 6.0,
      children: List<Widget>.generate(mList.length, (int index) {
        return ChoiceChip(
          label: Text(mList[index].name!),
          selected: true,
          onSelected: (value) {},
        );
      }),
    );
  }
}
