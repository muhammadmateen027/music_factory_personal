import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'wiki.dart';
import 'tracks.dart';
import 'tags.dart';
import '../global/global.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class AlbumData extends HiveObject {
  @HiveField(0)
  String? _listeners;
  @HiveField(1)
  String? _playcount;
  @HiveField(2)
  Wiki? _wiki;
  @HiveField(3)
  Tracks? _tracks;
  @HiveField(4)
  List<Image>? _image;
  @HiveField(5)
  Tags? _tags;
  @HiveField(6)
  String? _url;
  @HiveField(7)
  String? _artist;
  @HiveField(8)
  String? _name;
  @HiveField(9)
  String? _mbid;

  String? get listeners => _listeners;

  String? get playcount => _playcount;

  Wiki? get wiki => _wiki;

  Tracks? get tracks => _tracks;

  List<Image>? get image => _image;

  Tags? get tags => _tags;

  String? get url => _url;

  String? get artistName => _artist;

  String? get name => _name;

  String? get mbid => _mbid;

  AlbumData(
      {String? listeners,
      String? playcount,
      Wiki? wiki,
      Tracks? tracks,
      List<Image>? image,
      Tags? tags,
      String? url,
      String? artist,
      String? name,
      String? mbid}) {
    _listeners = listeners;
    _playcount = playcount;
    _wiki = wiki;
    _tracks = tracks;
    _image = image;
    _tags = tags;
    _url = url;
    _artist = artist;
    _name = name;
    _mbid = mbid;
  }

  factory AlbumData.fromJson(Map<String, dynamic> json) =>
      _$AlbumDataFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDataToJson(this);
}
