// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    name: json['name'] as String?,
    playcount: json['playcount'] as int?,
    url: json['url'] as String?,
    artist: json['artist'] == null
        ? null
        : ArtistDetail.fromJson(json['artist'] as Map<String, dynamic>),
    image: (json['image'] as List<dynamic>?)
        ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'name': instance.name,
      'playcount': instance.playcount,
      'url': instance.url,
      'artist': instance.artist?.toJson(),
      'image': instance.image?.map((e) => e.toJson()).toList(),
    };
