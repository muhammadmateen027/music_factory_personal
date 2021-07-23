import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_detail.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class ArtistDetail {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;

  ArtistDetail({this.name, this.url});

  factory ArtistDetail.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailToJson(this);
}
