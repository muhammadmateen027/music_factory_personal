// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WikiAdapter extends TypeAdapter<Wiki> {
  @override
  final int typeId = 1;

  @override
  Wiki read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wiki()
      .._published = fields[0] as String?
      .._content = fields[1] as String?
      .._summary = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, Wiki obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._published)
      ..writeByte(1)
      ..write(obj._content)
      ..writeByte(2)
      ..write(obj._summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WikiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wiki _$WikiFromJson(Map<String, dynamic> json) {
  return Wiki(
    published: json['published'] as String?,
    content: json['content'] as String?,
    summary: json['summary'] as String?,
  );
}

Map<String, dynamic> _$WikiToJson(Wiki instance) => <String, dynamic>{
      'published': instance.published,
      'content': instance.content,
      'summary': instance.summary,
    };
