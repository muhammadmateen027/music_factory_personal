import 'package:json_annotation/json_annotation.dart';

import '../model.dart';
import 'attr.dart';
part 'top_albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Topalbums {
  List<Album>? album;
  Attr? attr;

  Topalbums({this.album, this.attr});
  factory Topalbums.fromJson(Map<String, dynamic> json) =>
      _$TopalbumsFromJson(json);
  Map<String, dynamic> toJson() => _$TopalbumsToJson(this);


  // Topalbums.fromJson(Map<String, dynamic> json) {
  //   if (json['album'] != null) {
  //     album = [];
  //     json['album'].forEach((v) {
  //       album?.add(Album.fromJson(v));
  //     });
  //   }
  //   attr = json['@attr'] != null ? Attr.fromJson(json['@attr']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (this.album != null) {
  //     data['album'] = this.album?.map((v) => v.toJson()).toList();
  //   }
  //   if (this.attr != null) {
  //     data['@attr'] = this.attr?.toJson();
  //   }
  //   return data;
  // }
}