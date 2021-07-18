
import 'artist_detail.dart';
import 'image.dart';

class Album {
  String? name;
  int? playcount;
  String? url;
  ArtistDetail? artist;
  List<Image>? images;

  Album({this.name, this.playcount, this.url, this.artist, this.images});

  Album.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playcount = json['playcount'];
    url = json['url'];
    artist = json['artist'] != null ? ArtistDetail.fromJson(json['artist']) : null;
    if (json['image'] != null) {
      images = [];
      json['image'].forEach((v) {
        images?.add(Image.fromJson(v));
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
    if (this.images != null) {
      data['image'] = this.images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}