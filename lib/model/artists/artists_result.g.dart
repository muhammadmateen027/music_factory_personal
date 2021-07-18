
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    openSearchQuery: json['opensearch:Query'] == null
        ? null
        : OpenSearchQuery.fromJson(
        json['opensearch:Query'] as Map<String, dynamic>),
    openSearchTotalResults: json['opensearch:totalResults'] as String?,
    openSearchStartIndex: json['opensearch:startIndex'] as String?,
    openSearchItemsPerPage: json['opensearch:itemsPerPage'] as String?,
    artistMatches: json['artistmatches'] == null
        ? null
        : Artistmatches.fromJson(json['artistmatches'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
  'opensearch:Query': instance.openSearchQuery?.toJson(),
  'opensearch:totalResults': instance.openSearchTotalResults,
  'opensearch:startIndex': instance.openSearchStartIndex,
  'opensearch:itemsPerPage': instance.openSearchItemsPerPage,
  'artistmatches': instance.artistMatches?.toJson(),
};