// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artists _$ArtistsFromJson(Map<String, dynamic> json) {
  return Artists(
    results: json['results'] == null
        ? null
        : Results.fromJson(json['results'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'results': instance.results,
    };
