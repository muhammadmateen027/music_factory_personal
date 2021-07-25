// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    name: json['name'] as String?,
    listeners: json['listeners'] as String?,
    mbid: json['mbid'] as String?,
    url: json['url'] as String?,
    streamable: json['streamable'] as String?,
    image: (json['image'] as List<dynamic>?)
        ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'name': instance.name,
      'listeners': instance.listeners,
      'mbid': instance.mbid,
      'url': instance.url,
      'streamable': instance.streamable,
      'image': instance.image?.map((e) => e.toJson()).toList(),
    };
