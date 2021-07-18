import 'package:json_annotation/json_annotation.dart';
import 'artists_result.dart';

part 'artists.g.dart';
/// results : {'query':{'text':'','role':'request','searchTerms':'cher','startPage':'1'},'totalResults':'69649','startIndex':'0','itemsPerPage':'30','artistmatches':{'artist':[{'name':'Cher','listeners':'1286343','mbid':'bfcc6d75-a6a5-4bc6-8282-47aec8531818','url':'https://www.last.fm/music/Cher','streamable':'0','image':[{'#text':'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'small'}]}]},'attr':{'que':'cher'}}

@JsonSerializable()
class Artists {
  Results? _results;

  Results? get results => _results;

  Artists({Results? results}) {
    _results = results;
  }

  factory Artists.fromJson(Map<String, dynamic> json) =>
      _$ArtistsFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistsToJson(this);

  // Artists.fromJson(dynamic json) {
  //   _results =
  //       json['results'] != null ? Results.fromJson(json['results']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   if (_results != null) {
  //     map['results'] = _results?.toJson();
  //   }
  //   return map;
  // }
}
