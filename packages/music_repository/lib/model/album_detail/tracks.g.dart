// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TracksAdapter extends TypeAdapter<Tracks> {
  @override
  final int typeId = 2;

  @override
  Tracks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tracks().._track = (fields[0] as List?)?.cast<Track>();
  }

  @override
  void write(BinaryWriter writer, Tracks obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._track);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TracksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracks _$TracksFromJson(Map<String, dynamic> json) {
  if (json['track'] == null || json['track'] == '') {
    return Tracks();
  }

  if (json['track'] is List<dynamic>?) {
    return Tracks(
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  var tracks = <Track>[];
  json.forEach((key, value) => tracks.add(Track.fromJson(value)));
  return Tracks(track: tracks);
}

Map<String, dynamic> _$TracksToJson(Tracks instance) => <String, dynamic>{
      'track': instance.track?.map((e) => e.toJson()).toList(),
    };
