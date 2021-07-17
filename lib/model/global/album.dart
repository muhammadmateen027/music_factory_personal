import 'package:hive/hive.dart';
import 'artist_detail.dart';
import 'image.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? playcount;
  @HiveField(2)
  String? url;
  @HiveField(3)
  ArtistDetail? artist;
  @HiveField(4)
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