import 'package:json_annotation/json_annotation.dart';
import 'matched_artists.dart';
import 'search_query.dart';

part 'artists_result.g.dart';

@JsonSerializable(explicitToJson: true)
class Results {
  OpenSearchQuery? _openSearchQuery;
  String? _openSearchTotalResults;
  String? _openSearchStartIndex;
  String? _openSearchItemsPerPage;
  Artistmatches? _artistMatches;

  OpenSearchQuery? get openSearchQuery => _openSearchQuery;

  String? get openSearchTotalResults => _openSearchTotalResults;

  String? get openSearchStartIndex => _openSearchStartIndex;

  String? get openSearchItemsPerPage => _openSearchItemsPerPage;

  Artistmatches? get artistMatches => _artistMatches;

  Results({
    OpenSearchQuery? openSearchQuery,
    String? openSearchTotalResults,
    String? openSearchStartIndex,
    String? openSearchItemsPerPage,
    Artistmatches? artistMatches,
  }) {
    _openSearchQuery = openSearchQuery;
    _openSearchTotalResults = openSearchTotalResults;
    _openSearchStartIndex = openSearchStartIndex;
    _openSearchItemsPerPage = openSearchItemsPerPage;
    _artistMatches = artistMatches;
  }

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}

//
// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'artists_result.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// Results _$ResultsFromJson(Map<String, dynamic> json) {
//   return Results(
//     openSearchQuery: json['opensearch:Query'] == null
//         ? null
//         : OpenSearchQuery.fromJson(
//         json['opensearch:Query'] as Map<String, dynamic>),
//     openSearchTotalResults: json['opensearch:totalResults'] as String?,
//     openSearchStartIndex: json['opensearch:startIndex'] as String?,
//     openSearchItemsPerPage: json['opensearch:itemsPerPage'] as String?,
//     artistMatches: json['artistmatches'] == null
//         ? null
//         : Artistmatches.fromJson(json['artistmatches'] as Map<String, dynamic>),
//   );
// }
//
// Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
//   'opensearch:Query': instance.openSearchQuery?.toJson(),
//   'opensearch:totalResults': instance.openSearchTotalResults,
//   'opensearch:startIndex': instance.openSearchStartIndex,
//   'opensearch:itemsPerPage': instance.openSearchItemsPerPage,
//   'artistmatches': instance.artistMatches?.toJson(),
// };

