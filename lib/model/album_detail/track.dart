import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../global/artist_detail.dart';
import 'streamable.dart';

part 'track.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(explicitToJson: true)
class Track extends HiveObject {
  @HiveField(0)
  ArtistDetail? _artist;
  @HiveField(1)
  int? _duration;
  @HiveField(2)
  String? _url;
  @HiveField(3)
  String? _name;
  @HiveField(4)
  Streamable? _streamable;

  ArtistDetail? get artist => _artist;
  int? get duration => _duration;
  String? get url => _url;
  String? get name => _name;
  Streamable? get streamable => _streamable;

  Track({
    ArtistDetail? artist,
    int? duration,
    String? url,
    String? name,
    Streamable? streamable}){
    _artist = artist;
    _duration = duration;
    _url = url;
    _name = name;
    _streamable = streamable;
  }


  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);

}