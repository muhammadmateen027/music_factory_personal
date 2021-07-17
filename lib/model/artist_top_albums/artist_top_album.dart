import '../model.dart';

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

class Album {
  String? name;
  int? playcount;
  String? url;
  ArtistDetail? artist;
  List<Image>? image;

  Album({this.name, this.playcount, this.url, this.artist, this.image});

  Album.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playcount = json['playcount'];
    url = json['url'];
    artist = json['artist'] != null ? ArtistDetail.fromJson(json['artist']) : null;
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(new Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['playcount'] = this.playcount;
    data['url'] = this.url;
    if (this.artist != null) {
      data['artist'] = this.artist?.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArtistDetail {
  String? name;
  String? url;

  ArtistDetail({this.name, this.url});

  ArtistDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
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
