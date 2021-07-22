// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    tag: (json['tag'] as List<dynamic>?)
        ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'tag': instance.tag?.map((e) => e.toJson()).toList(),
    };
