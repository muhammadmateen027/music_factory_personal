// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumData _$AlbumFromJson(Map<String, dynamic> json) {
  Tags? tags;
  if (json['tags'].runtimeType == String) {
    tags = null;
  } else {
    tags = Tags.fromJson(json['tags'] as Map<String, dynamic>);
  }

  return AlbumData(
    listeners: json['listeners'] as String?,
    playcount: json['playcount'] as String?,
    wiki: json['wiki'] == null
        ? null
        : Wiki.fromJson(json['wiki'] as Map<String, dynamic>),
    tracks: json['tracks'] == null
        ? null
        : Tracks.fromJson(json['tracks'] as Map<String, dynamic>),
    image: (json['image'] as List<dynamic>?)
        ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
    tags: tags,
    url: json['url'] as String?,
    artist: json['artist'] as String?,
    name: json['name'] as String?,
    mbid: json['mbid'] as String?,
  );
}

Map<String, dynamic> _$AlbumToJson(AlbumData instance) => <String, dynamic>{
      'listeners': instance.listeners,
      'playcount': instance.playcount,
      'wiki': instance.wiki?.toJson(),
      'tracks': instance.tracks?.toJson(),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'tags': instance.tags?.toJson(),
      'url': instance.url,
      'artist': instance.artistName,
      'name': instance.name,
      'mbid': instance.mbid,
    };
