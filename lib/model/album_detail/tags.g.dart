// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) {

  if (json['tag'] == null || json['tag'] == '') {
    return Tags();
  }

  if (json['tag'] is List<dynamic>?) {
    return Tags(
      tag: (json['tag'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  var tags = <Tag>[];
  json.forEach((k, v) => tags.add(Tag.fromJson(v)));
  return Tags(tag: tags);
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'tag': instance.tag?.map((e) => e.toJson()).toList(),
    };
