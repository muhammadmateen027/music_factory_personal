// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreamableAdapter extends TypeAdapter<Streamable> {
  @override
  final int typeId = 5;

  @override
  Streamable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Streamable()
      .._fulltrack = fields[0] as String?
      .._text = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, Streamable obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._fulltrack)
      ..writeByte(1)
      ..write(obj._text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
