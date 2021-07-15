import '../global/global.dart';
/// artist : [{'name':'Cher','listeners':'1286343','mbid':'bfcc6d75-a6a5-4bc6-8282-47aec8531818','url':'https://www.last.fm/music/Cher','streamable':'0','image':[{'#text':'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'small'}]}]

class Artistmatches {
  List<Artist>? _artist;

  List<Artist>? get artist => _artist;

  Artistmatches({
    List<Artist>? artist}){
    _artist = artist;
  }

  Artistmatches.fromJson(dynamic json) {
    if (json['artist'] != null) {
      _artist = [];
      json['artist'].forEach((v) {
        _artist?.add(Artist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_artist != null) {
      map['artist'] = _artist?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}