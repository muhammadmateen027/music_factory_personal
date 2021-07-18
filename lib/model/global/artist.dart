import 'image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

/// name : 'Cher'
/// listeners : '1286343'
/// mbid : 'bfcc6d75-a6a5-4bc6-8282-47aec8531818'
/// url : 'https://www.last.fm/music/Cher'
/// streamable : '0'
/// image : [{'#text':'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'small'},{'#text':'https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'medium'},{'#text':'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'large'},{'#text':'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png','size':'extralarge'},{'#text':'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png','size':'mega'}]

@JsonSerializable(explicitToJson: true)
class Artist {
  String? _name;
  String? _listeners;
  String? _mbid;
  String? _url;
  String? _streamable;
  List<Image>? _image;

  String? get name => _name;

  String? get listeners => _listeners;

  String? get mbid => _mbid;

  String? get url => _url;

  String? get streamable => _streamable;

  List<Image>? get image => _image;

  Artist(
      {String? name,
      String? listeners,
      String? mbid,
      String? url,
      String? streamable,
      List<Image>? image}) {
    _name = name;
    _listeners = listeners;
    _mbid = mbid;
    _url = url;
    _streamable = streamable;
    _image = image;
  }

  factory Artist.fromJson(Map<String, dynamic> json) =>
      _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
