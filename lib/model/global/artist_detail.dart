import 'package:json_annotation/json_annotation.dart';

part 'artist_detail.g.dart';

@JsonSerializable()
class ArtistDetail {
  String? name;
  String? url;

  ArtistDetail({this.name, this.url});

  factory ArtistDetail.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailToJson(this);
}
