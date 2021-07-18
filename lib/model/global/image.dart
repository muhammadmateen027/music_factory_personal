import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  dynamic _text;
  String? _size;

  dynamic get text => _text;

  String? get size => _size;

  Image({dynamic text, String? size}) {
    _text = text;
    _size = size;
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
