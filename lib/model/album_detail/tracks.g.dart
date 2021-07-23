// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracks _$TracksFromJson(Map<String, dynamic> json) {

  if (json['track'] == null || json['track'] == '') {
    return Tracks();
  }

  if (json['track'] is List<dynamic>?) {
    return Tracks(
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  var tracks = <Track>[];
  json.forEach((key, value) => tracks.add(Track.fromJson(value)));
  return Tracks(track: tracks);
}

Map<String, dynamic> _$TracksToJson(Tracks instance) => <String, dynamic>{
      'track': instance.track?.map((e) => e.toJson()).toList(),
    };
