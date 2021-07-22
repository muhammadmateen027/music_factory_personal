import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  String? _name;
  String? _url;

  String? get name => _name;

  String? get url => _url;

  Tag({
    String? name,
    String? url,
  }) {
    _name = name;
    _url = url;
  }

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
