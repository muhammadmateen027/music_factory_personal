// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Streamable _$StreamableFromJson(Map<String, dynamic> json) {
  return Streamable(
    fulltrack: json['fulltrack'] as String?,
    text: json['text'] as String?,
  );
}

Map<String, dynamic> _$StreamableToJson(Streamable instance) =>
    <String, dynamic>{
      'fulltrack': instance.fulltrack,
      'text': instance.text,
    };
