// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topalbums _$TopalbumsFromJson(Map<String, dynamic> json) {
  return Topalbums(
    album: (json['album'] as List<dynamic>?)
        ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList(),
    attr: json['@attr'] == null
        ? null
        : Attr.fromJson(json['@attr'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopalbumsToJson(Topalbums instance) => <String, dynamic>{
      'album': instance.album?.map((e) => e.toJson()).toList(),
      '@attr': instance.attr?.toJson(),
    };
