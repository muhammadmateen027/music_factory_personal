import 'package:json_annotation/json_annotation.dart';
import 'top_albums.dart';

part 'artist_top_album.g.dart';
@JsonSerializable(explicitToJson: true)
class TopAlbumsModel {
  TopAlbumsModel({this.topalbums});

  Topalbums? topalbums;

  factory TopAlbumsModel.fromJson(Map<String, dynamic> json) =>
      _$TopAlbumsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopAlbumsModelToJson(this);

  // TopAlbumsModel.fromJson(Map<String, dynamic> json) {
  //   topalbums = json['topalbums'] != null
  //       ? Topalbums.fromJson(json['topalbums'])
  //       : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (this.topalbums != null) {
  //     data['topalbums'] = this.topalbums?.toJson();
  //   }
  //   return data;
  // }
}
