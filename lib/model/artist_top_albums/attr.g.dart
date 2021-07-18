// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attr _$AttrFromJson(Map<String, dynamic> json) {
  return Attr(
    artist: json['artist'] as String?,
    page: json['page'] as String?,
    perPage: json['perPage'] as String?,
    totalPages: json['totalPages'] as String?,
    total: json['total'] as String?,
  );
}

Map<String, dynamic> _$AttrToJson(Attr instance) => <String, dynamic>{
      'artist': instance.artist,
      'page': instance.page,
      'perPage': instance.perPage,
      'totalPages': instance.totalPages,
      'total': instance.total,
    };
