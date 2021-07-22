import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';
/// tag : [{"name":"pop","url":"https://www.last.fm/tag/pop"},{"name":"dance","url":"https://www.last.fm/tag/dance"},{"name":"90s","url":"https://www.last.fm/tag/90s"},{"name":"1998","url":"https://www.last.fm/tag/1998"},{"name":"cher","url":"https://www.last.fm/tag/cher"}]

part 'tags.g.dart';

@JsonSerializable(explicitToJson: true)
class Tags {
  List<Tag>? _tag;

  List<Tag>? get tag => _tag;

  Tags({
    List<Tag>? tag}){
    _tag = tag;
  }

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}

/// name : "pop"
/// url : "https://www.last.fm/tag/pop"