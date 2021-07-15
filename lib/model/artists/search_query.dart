/// text : ''
/// role : 'request'
/// searchTerms : 'cher'
/// startPage : '1'

class OpenSearchQuery {
  String? _text;
  String? _role;
  String? _searchTerms;
  String? _startPage;

  String? get text => _text;
  String? get role => _role;
  String? get searchTerms => _searchTerms;
  String? get startPage => _startPage;

  OpenSearchQuery({
    String? text,
    String? role,
    String? searchTerms,
    String? startPage}){
    _text = text;
    _role = role;
    _searchTerms = searchTerms;
    _startPage = startPage;
  }

  OpenSearchQuery.fromJson(dynamic json) {
    _text = json['text'];
    _role = json['role'];
    _searchTerms = json['searchTerms'];
    _startPage = json['startPage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['text'] = _text;
    map['role'] = _role;
    map['searchTerms'] = _searchTerms;
    map['startPage'] = _startPage;
    return map;
  }

}