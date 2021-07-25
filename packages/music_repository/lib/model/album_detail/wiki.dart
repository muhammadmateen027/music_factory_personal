import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wiki.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Wiki {
  @HiveField(0)
  String? _published;
  @HiveField(1)
  String? _content;
  @HiveField(2)
  String? _summary;

  String? get published => _published;
  String? get content => _content;
  String? get summary => _summary;

  Wiki({
    String? published,
    String? content,
    String? summary}){
    _published = published;
    _content = content;
    _summary = summary;
  }


  factory Wiki.fromJson(Map<String, dynamic> json) => _$WikiFromJson(json);

  Map<String, dynamic> toJson() => _$WikiToJson(this);

}