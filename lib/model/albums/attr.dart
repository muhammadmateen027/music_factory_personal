
/// artist : "Believe"
/// page : "1"
/// perPage : "50"
/// totalPages : "19"
/// total : "932"

class Attr {
  Attr({
    String? artist,
    String? page,
    String? perPage,
    String? totalPages,
    String? total}){
    _artist = artist;
    _page = page;
    _perPage = perPage;
    _totalPages = totalPages;
    _total = total;
  }

  String? _artist;
  String? _page;
  String? _perPage;
  String? _totalPages;
  String? _total;

  String? get artist => _artist;
  String? get page => _page;
  String? get perPage => _perPage;
  String? get totalPages => _totalPages;
  String? get total => _total;


  Attr.fromJson(dynamic json) {
    _artist = json["artist"];
    _page = json["page"];
    _perPage = json["perPage"];
    _totalPages = json["totalPages"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["artist"] = _artist;
    map["page"] = _page;
    map["perPage"] = _perPage;
    map["totalPages"] = _totalPages;
    map["total"] = _total;
    return map;
  }

}