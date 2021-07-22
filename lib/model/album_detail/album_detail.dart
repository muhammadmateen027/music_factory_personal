import 'package:json_annotation/json_annotation.dart';

import '../global/global.dart';

part 'album_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumDetail {
  Album? _album;

  Album? get album => _album;

  AlbumDetail({
      Album? album}){
    _album = album;
}


  factory AlbumDetail.fromJson(Map<String, dynamic> json) => _$AlbumDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDetailToJson(this);
}










