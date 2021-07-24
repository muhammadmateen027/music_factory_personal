part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {
  const AlbumsEvent();

  List<Object> get props => [];
}

class LoadTopTags extends AlbumsEvent {
  const LoadTopTags(this.artist);

  final Artist artist;

  @override
  List<Object> get props => [artist];
}
class LoadAlbumDetail extends AlbumsEvent {
  const LoadAlbumDetail(this.albumDetailModel);

  final AlbumDetailModel albumDetailModel;

  @override
  List<Object> get props => [albumDetailModel];
}

class SaveDeleteAlbumEvent extends AlbumsEvent {}
