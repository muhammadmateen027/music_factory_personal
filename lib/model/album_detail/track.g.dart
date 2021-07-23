// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 3;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track()
      .._artist = fields[0] as ArtistDetail?
      .._duration = fields[1] as int?
      .._url = fields[2] as String?
      .._name = fields[3] as String?
      .._streamable = fields[4] as Streamable?;
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._artist)
      ..writeByte(1)
      ..write(obj._duration)
      ..writeByte(2)
      ..write(obj._url)
      ..writeByte(3)
      ..write(obj._name)
      ..writeByte(4)
      ..write(obj._streamable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    artist: json['artist'] == null
        ? null
        : ArtistDetail.fromJson(json['artist'] as Map<String, dynamic>),
    duration: json['duration'] as int?,
    url: json['url'] as String?,
    name: json['name'] as String?,
    streamable: json['streamable'] == null
        ? null
        : Streamable.fromJson(json['streamable'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'artist': instance.artist?.toJson(),
      'duration': instance.duration,
      'url': instance.url,
      'name': instance.name,
      'streamable': instance.streamable?.toJson(),
    };
