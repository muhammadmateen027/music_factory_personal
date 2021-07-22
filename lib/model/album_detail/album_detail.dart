import 'package:json_annotation/json_annotation.dart';
import 'album.dart';
part 'album_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumDetail {
  AlbumData? _album;

  AlbumData? get album => _album;

  AlbumDetail({
    AlbumData? album}){
    _album = album;
}


  factory AlbumDetail.fromJson(Map<String, dynamic> json) => _$AlbumDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDetailToJson(this);
}










