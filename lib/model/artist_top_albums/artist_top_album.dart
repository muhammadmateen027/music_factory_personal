

import 'package:music_factory/model/global/album.dart';

class TopAlbumsModel {
  TopAlbumsModel({this.topalbums});

  Topalbums? topalbums;

  TopAlbumsModel.fromJson(Map<String, dynamic> json) {
    topalbums = json['topalbums'] != null
        ? Topalbums.fromJson(json['topalbums'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.topalbums != null) {
      data['topalbums'] = this.topalbums?.toJson();
    }
    return data;
  }
}

class Topalbums {
  List<Album>? album;
  Attr? attr;

  Topalbums({this.album, this.attr});

  Topalbums.fromJson(Map<String, dynamic> json) {
    if (json['album'] != null) {
      album = [];
      json['album'].forEach((v) {
        album?.add(Album.fromJson(v));
      });
    }
    attr = json['@attr'] != null ? Attr.fromJson(json['@attr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album?.map((v) => v.toJson()).toList();
    }
    if (this.attr != null) {
      data['@attr'] = this.attr?.toJson();
    }
    return data;
  }
}

class Attr {
  String? artist;
  String? page;
  String? perPage;
  String? totalPages;
  String? total;

  Attr({this.artist, this.page, this.perPage, this.totalPages, this.total});

  Attr.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['artist'] = this.artist;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['total'] = this.total;
    return data;
  }
}
