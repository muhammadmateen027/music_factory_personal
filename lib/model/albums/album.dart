
import '../global/global.dart';

/// name : 'Hope to See Another Day'
/// playcount : 91257
/// mbid : '95039e73-8d41-4cd6-904b-04e7132f7558'
/// url : 'https://www.last.fm/music/Believe/Hope+to+See+Another+Day'
/// artist : {'name':'Believe','mbid':'60566db9-5b17-47c4-9980-d3d39664e768','url':'https://www.last.fm/music/Believe'}
/// image : [{'text':'https://lastfm.freetls.fastly.net/i/u/34s/56880ca4c9d742838a96edbd3ead894e.png','size':'small'},{'text':'https://lastfm.freetls.fastly.net/i/u/64s/56880ca4c9d742838a96edbd3ead894e.png','size':'medium'},{'text':'https://lastfm.freetls.fastly.net/i/u/174s/56880ca4c9d742838a96edbd3ead894e.png','size':'large'},{'text':'https://lastfm.freetls.fastly.net/i/u/300x300/56880ca4c9d742838a96edbd3ead894e.png','size':'extralarge'}]

class Album {
  Album({
    String? name,
    int? playcount,
    String? mbid,
    String? url,
    Artist? artist,
    List<Image>? image}){
    _name = name;
    _playcount = playcount;
    _mbid = mbid;
    _url = url;
    _artist = artist;
    _image = image;
  }
  
  String? _name;
  int? _playcount;
  String? _mbid;
  String? _url;
  Artist? _artist;
  List<Image>? _image;

  String? get name => _name;
  int? get playcount => _playcount;
  String? get mbid => _mbid;
  String? get url => _url;
  Artist? get artist => _artist;
  List<Image>? get image => _image;
  

  Album.fromJson(dynamic json) {
    _name = json['name'];
    _playcount = json['playcount'];
    _mbid = json['mbid'];
    _url = json['url'];
    _artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    if (json['image'] != null) {
      _image = [];
      json['image'].forEach((v) {
        _image?.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['playcount'] = _playcount;
    map['mbid'] = _mbid;
    map['url'] = _url;
    if (_artist != null) {
      map['artist'] = _artist?.toJson();
    }
    if (_image != null) {
      map['image'] = _image?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}