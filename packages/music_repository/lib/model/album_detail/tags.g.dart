// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagsAdapter extends TypeAdapter<Tags> {
  @override
  final int typeId = 7;

  @override
  Tags read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tags().._tag = (fields[0] as List?)?.cast<Tag>();
  }

  @override
  void write(BinaryWriter writer, Tags obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) {
  if (json['tag'] == null || json['tag'] == '') {
    return Tags();
  }

  if (json['tag'] is List<dynamic>?) {
    return Tags(
      tag: (json['tag'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  var tags = <Tag>[];
  json.forEach((k, v) => tags.add(Tag.fromJson(v)));
  return Tags(tag: tags);
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'tag': instance.tag?.map((e) => e.toJson()).toList(),
    };
