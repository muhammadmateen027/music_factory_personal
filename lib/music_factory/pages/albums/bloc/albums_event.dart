part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {
  const AlbumsEvent();

  List<Object> get props => [];
}

// This event will take [Artist] as a param and will pass to the bloc
class LoadTopAlbums extends AlbumsEvent {
  const LoadTopAlbums(this.artist);

  final Artist artist;

  @override
  List<Object> get props => [artist];
}

// This event will take [AlbumDetailModel] as a param and will pass to the bloc
class LoadAlbumDetail extends AlbumsEvent {
  const LoadAlbumDetail(this.albumDetailModel);

  final AlbumDetailModel albumDetailModel;

  @override
  List<Object> get props => [albumDetailModel];
}
// This event will perform action to either save or delete the item
class SaveDeleteAlbumEvent extends AlbumsEvent {}
