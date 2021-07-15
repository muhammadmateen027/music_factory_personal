import 'top_album.dart';

/// topalbums : {'album':[{'name':'Hope to See Another Day','playcount':91257,'mbid':'95039e73-8d41-4cd6-904b-04e7132f7558','url':'https://www.last.fm/music/Believe/Hope+to+See+Another+Day','artist':{'name':'Believe','mbid':'60566db9-5b17-47c4-9980-d3d39664e768','url':'https://www.last.fm/music/Believe'},'image':[{'text':'https://lastfm.freetls.fastly.net/i/u/34s/56880ca4c9d742838a96edbd3ead894e.png','size':'small'},{'text':'https://lastfm.freetls.fastly.net/i/u/64s/56880ca4c9d742838a96edbd3ead894e.png','size':'medium'},{'text':'https://lastfm.freetls.fastly.net/i/u/174s/56880ca4c9d742838a96edbd3ead894e.png','size':'large'},{'text':'https://lastfm.freetls.fastly.net/i/u/300x300/56880ca4c9d742838a96edbd3ead894e.png','size':'extralarge'}]}],'attr':{'artist':'Believe','page':'1','perPage':'50','totalPages':'19','total':'932'}}

class Albums {
  Topalbums? _topalbums;

  Topalbums? get topalbums => _topalbums;

  Albums({Topalbums? topalbums}) {
    _topalbums = topalbums;
  }

  Albums.fromJson(dynamic json) {
    _topalbums = json['topalbums'] != null
        ? Topalbums.fromJson(json['topalbums'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_topalbums != null) {
      map['topalbums'] = _topalbums?.toJson();
    }
    return map;
  }
}
