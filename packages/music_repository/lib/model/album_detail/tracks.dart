import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'track.dart';

part 'tracks.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Tracks extends HiveObject {
  @HiveField(0)
  List<Track>? _track;

  List<Track>? get track => _track;

  Tracks({List<Track>? track}) {
    _track = track;
  }


  factory Tracks.fromJson(Map<String, dynamic> json) => _$TracksFromJson(json);

  Map<String, dynamic> toJson() => _$TracksToJson(this);
}
