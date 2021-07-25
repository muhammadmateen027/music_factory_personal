import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class Image {
  @HiveField(0)
  String? _text;
  @HiveField(1)
  String? _size;

  String? get text => _text;

  String? get size => _size;

  Image({String? text, String? size}) {
    _text = text;
    _size = size;
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
