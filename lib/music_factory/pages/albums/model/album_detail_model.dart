// This model class will be used to pass the data from albums page to detail
// page. The page will call the event to load respective album's detail
class AlbumDetailModel {
  AlbumDetailModel({this.albumName, this.artistName, this.mbid, this.url});

  // artist name and albumName will be helpful to find album detail
  String? albumName;
  String? artistName;

  // MBID is not the actual or correct id
  String? mbid;

  // MBID can't use as a key because it keeps changing from albums to album
  // detail page. So decided to use album's url as a key to save itme in
  // the hive storage
  String? url;
}