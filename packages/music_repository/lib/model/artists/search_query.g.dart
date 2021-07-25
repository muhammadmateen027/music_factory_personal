// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenSearchQuery _$OpenSearchQueryFromJson(Map<String, dynamic> json) {
  return OpenSearchQuery(
    text: json['text'] as String?,
    role: json['role'] as String?,
    searchTerms: json['searchTerms'] as String?,
    startPage: json['startPage'] as String?,
  );
}

Map<String, dynamic> _$OpenSearchQueryToJson(OpenSearchQuery instance) =>
    <String, dynamic>{
      'text': instance.text,
      'role': instance.role,
      'searchTerms': instance.searchTerms,
      'startPage': instance.startPage,
    };
