import 'package:music_factory/model/global/album.dart';
import 'attr.dart';

/// album : [{'name':'Hope to See Another Day','playcount':91257,'mbid':'95039e73-8d41-4cd6-904b-04e7132f7558','url':'https://www.last.fm/music/Believe/Hope+to+See+Another+Day','artist':{'name':'Believe','mbid':'60566db9-5b17-47c4-9980-d3d39664e768','url':'https://www.last.fm/music/Believe'},'image':[{'text':'https://lastfm.freetls.fastly.net/i/u/34s/56880ca4c9d742838a96edbd3ead894e.png','size':'small'},{'text':'https://lastfm.freetls.fastly.net/i/u/64s/56880ca4c9d742838a96edbd3ead894e.png','size':'medium'},{'text':'https://lastfm.freetls.fastly.net/i/u/174s/56880ca4c9d742838a96edbd3ead894e.png','size':'large'},{'text':'https://lastfm.freetls.fastly.net/i/u/300x300/56880ca4c9d742838a96edbd3ead894e.png','size':'extralarge'}]}]
/// attr : {'artist':'Believe','page':'1','perPage':'50','totalPages':'19','total':'932'}

class Topalbums {
  List<Album>? _album;
  Attr? _attr;

  List<Album>? get album => _album;
  Attr? get attr => _attr;

  Topalbums({
    List<Album>? album,
    Attr? attr}){
    _album = album;
    _attr = attr;
  }

  Topalbums.fromJson(dynamic json) {
    if (json['album'] != null) {
      _album = [];
      json['album'].forEach((v) {
        _album?.add(Album.fromJson(v));
      });
    }
    _attr = json['@attr'] != null ? Attr.fromJson(json['@attr']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_album != null) {
      map['album'] = _album?.map((v) => v.toJson()).toList();
    }
    if (_attr != null) {
      map['@attr'] = _attr?.toJson();
    }
    return map;
  }

}