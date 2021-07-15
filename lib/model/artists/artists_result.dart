import 'matched_artists.dart';
import 'search_query.dart';

/// query : {'text':'','role':'request','searchTerms':'cher','startPage':'1'}
/// totalResults : '69649'
/// startIndex : '0'
/// itemsPerPage : '30'
/// artistmatches : {'artist':[{'name':'Cher','listeners':'1286343','mbid':'bfcc6d75-a6a5-4bc6-8282-47aec8531818','url':'https://www.last.fm/music/Cher','streamable':'0','image':[{'#text':'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png','size':'small'}]}]}
/// attr : {'que':'cher'}

class Results {
  OpenSearchQuery? _openSearchQuery;
  String? _totalResults;
  String? _startIndex;
  String? _itemsPerPage;
  Artistmatches? _artistmatches;

  OpenSearchQuery? get query => _openSearchQuery;

  String? get totalResults => _totalResults;

  String? get startIndex => _startIndex;

  String? get itemsPerPage => _itemsPerPage;

  Artistmatches? get artistmatches => _artistmatches;

  Results({
    OpenSearchQuery? query,
    String? openSearchTotalResults,
    String? openSearchStartIndex,
    String? openSearchItemsPerPage,
    Artistmatches? artistmatches,
  }) {
    _openSearchQuery = query;
    _totalResults = openSearchTotalResults;
    _startIndex = openSearchStartIndex;
    _itemsPerPage = openSearchItemsPerPage;
    _artistmatches = artistmatches;
  }

  Results.fromJson(dynamic json) {
    _openSearchQuery = json['opensearch:Query'] != null
        ? OpenSearchQuery.fromJson(json['opensearch:Query'])
        : null;
    _totalResults = json['opensearch:totalResults'];
    _startIndex = json['opensearch:startIndex'];
    _itemsPerPage = json['opensearch:itemsPerPage'];
    _artistmatches = json['artistmatches'] != null
        ? Artistmatches.fromJson(json['artistmatches'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_openSearchQuery != null) {
      map['opensearch:Query'] = _openSearchQuery?.toJson();
    }
    map['opensearch:totalResults'] = _totalResults;
    map['opensearch:startIndex'] = _startIndex;
    map['opensearch:itemsPerPage'] = _itemsPerPage;
    if (_artistmatches != null) {
      map['artistmatches'] = _artistmatches?.toJson();
    }
    return map;
  }
}
