// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    artist: json['artist'] == null
        ? null
        : ArtistDetail.fromJson(json['artist'] as Map<String, dynamic>),
    duration: json['duration'] as int?,
    url: json['url'] as String?,
    name: json['name'] as String?,
    streamable: json['streamable'] == null
        ? null
        : Streamable.fromJson(json['streamable'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'artist': instance.artist?.toJson(),
      'duration': instance.duration,
      'url': instance.url,
      'name': instance.name,
      'streamable': instance.streamable?.toJson(),
    };
