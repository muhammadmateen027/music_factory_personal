

import 'package:json_annotation/json_annotation.dart';

part 'streamable.g.dart';

@JsonSerializable()
class Streamable {
  String? _fulltrack;
  String? _text;

  String? get fulltrack => _fulltrack;
  String? get text => _text;

  Streamable({
    String? fulltrack,
    String? text}){
    _fulltrack = fulltrack;
    _text = text;
  }


  factory Streamable.fromJson(Map<String, dynamic> json) => _$StreamableFromJson(json);

  Map<String, dynamic> toJson() => _$StreamableToJson(this);

}