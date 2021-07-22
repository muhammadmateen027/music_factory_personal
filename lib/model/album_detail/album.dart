import 'package:json_annotation/json_annotation.dart';

import 'wiki.dart';
import 'tracks.dart';
import 'tags.dart';
import '../global/global.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumData {
  String? _listeners;
  String? _playcount;
  Wiki? _wiki;
  Tracks? _tracks;
  List<Image>? _image;
  Tags? _tags;
  String? _url;
  String? _artist;
  String? _name;
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

  factory AlbumData.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
