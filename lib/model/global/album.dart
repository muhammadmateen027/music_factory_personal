import 'package:json_annotation/json_annotation.dart';

import 'artist_detail.dart';
import 'image.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album {
  String? name;
  int? playcount;
  String? url;
  ArtistDetail? artist;
  List<Image>? image;
  String? mbid;

  Album({this.name, this.playcount, this.url, this.artist, this.image, this.mbid});
  factory Album.fromJson(Map<String, dynamic> json) =>
      _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}