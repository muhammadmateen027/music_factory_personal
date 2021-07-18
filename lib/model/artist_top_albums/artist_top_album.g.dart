// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_top_album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAlbumsModel _$TopAlbumsModelFromJson(Map<String, dynamic> json) {
  return TopAlbumsModel(
    topalbums: json['topalbums'] == null
        ? null
        : Topalbums.fromJson(json['topalbums'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopAlbumsModelToJson(TopAlbumsModel instance) =>
    <String, dynamic>{
      'topalbums': instance.topalbums?.toJson(),
    };
