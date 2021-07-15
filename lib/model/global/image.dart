
/// text : 'https://lastfm.freetls.fastly.net/i/u/34s/56880ca4c9d742838a96edbd3ead894e.png'
/// size : 'small'

class Image {
  String? _text;
  String? _size;

  String? get text => _text;
  String? get size => _size;

  Image({
    String? text,
    String? size}){
    _text = text;
    _size = size;
  }

  Image.fromJson(dynamic json) {
    _text = json['#text'];
    _size = json['size'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['#text'] = _text;
    map['size'] = _size;
    return map;
  }

}