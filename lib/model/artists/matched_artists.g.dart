// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artistmatches _$ArtistmatchesFromJson(Map<String, dynamic> json) {
  return Artistmatches(
    artist: (json['artist'] as List<dynamic>?)
        ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArtistmatchesToJson(Artistmatches instance) =>
    <String, dynamic>{
      'artist': instance.artist?.map((e) => e.toJson()).toList(),
    };
