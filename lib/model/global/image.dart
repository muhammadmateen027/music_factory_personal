

/// text : 'https://lastfm.freetls.fastly.net/i/u/34s/56880ca4c9d742838a96edbd3ead894e.png'
/// size : 'small'

class Image {
  dynamic _text;
  String? _size;

  dynamic get text => _text;

  String? get size => _size;

  Image({
    dynamic text,
    String? size,
  }) {
    _text = text;
    _size = size;
  }

  Image.fromJson(dynamic json) {
    _text = json['#text'] as String;
    _size = json['size'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['text'] = _text;
    map['size'] = _size;
    return map;
  }
}
