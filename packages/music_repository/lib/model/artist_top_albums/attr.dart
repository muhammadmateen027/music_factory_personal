import 'package:json_annotation/json_annotation.dart';
part 'attr.g.dart';

@JsonSerializable()
class Attr {
  String? artist;
  String? page;
  String? perPage;
  String? totalPages;
  String? total;

  Attr({this.artist, this.page, this.perPage, this.totalPages, this.total});

  factory Attr.fromJson(Map<String, dynamic> json) =>
      _$AttrFromJson(json);
  Map<String, dynamic> toJson() => _$AttrToJson(this);
}