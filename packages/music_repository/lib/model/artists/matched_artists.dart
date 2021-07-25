import 'package:json_annotation/json_annotation.dart';

import '../global/global.dart';
part 'matched_artists.g.dart';

@JsonSerializable(explicitToJson: true)
class Artistmatches {
  List<Artist>? _artist;

  List<Artist>? get artist => _artist;

  Artistmatches({
    List<Artist>? artist}){
    _artist = artist;
  }

  factory Artistmatches.fromJson(Map<String, dynamic> json) =>
      _$ArtistmatchesFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistmatchesToJson(this);


}