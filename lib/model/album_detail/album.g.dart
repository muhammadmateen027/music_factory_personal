// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumDataAdapter extends TypeAdapter<AlbumData> {
  @override
  final int typeId = 0;

  @override
  AlbumData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumData()
      .._listeners = fields[0] as String?
      .._playcount = fields[1] as String?
      .._wiki = fields[2] as Wiki?
      .._tracks = fields[3] as Tracks?
      .._image = (fields[4] as List?)?.cast<Image>()
      .._tags = fields[5] as Tags?
      .._url = fields[6] as String?
      .._artist = fields[7] as String?
      .._name = fields[8] as String?
      .._mbid = fields[9] as String?;
  }

  @override
  void write(BinaryWriter writer, AlbumData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._listeners)
      ..writeByte(1)
      ..write(obj._playcount)
      ..writeByte(2)
      ..write(obj._wiki)
      ..writeByte(3)
      ..write(obj._tracks)
      ..writeByte(4)
      ..write(obj._image)
      ..writeByte(5)
      ..write(obj._tags)
      ..writeByte(6)
      ..write(obj._url)
      ..writeByte(7)
      ..write(obj._artist)
      ..writeByte(8)
      ..write(obj._name)
      ..writeByte(9)
      ..write(obj._mbid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumData _$AlbumDataFromJson(Map<String, dynamic> json) {
  Tags? tags;
  if (json['tags'].runtimeType == String) {
    tags = null;
  } else {
    tags = Tags.fromJson(json['tags'] as Map<String, dynamic>);
  }

  return AlbumData(
    listeners: json['listeners'] as String?,
    playcount: json['playcount'] as String?,
    wiki: json['wiki'] == null
        ? null
        : Wiki.fromJson(json['wiki'] as Map<String, dynamic>),
    tracks: json['tracks'] == null
        ? null
        : Tracks.fromJson(json['tracks'] as Map<String, dynamic>),
    image: (json['image'] as List<dynamic>?)
        ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
    tags: tags,
    url: json['url'] as String?,
    artist: json['artist'] as String?,
    name: json['name'] as String?,
    mbid: json['mbid'] as String?,
  );
}

Map<String, dynamic> _$AlbumDataToJson(AlbumData instance) => <String, dynamic>{
      'listeners': instance.listeners,
      'playcount': instance.playcount,
      'wiki': instance.wiki?.toJson(),
      'tracks': instance.tracks?.toJson(),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'tags': instance.tags?.toJson(),
      'url': instance.url,
      'artist': instance.artistName,
      'name': instance.name,
      'mbid': instance.mbid,
    };
