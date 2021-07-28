part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {
  const AlbumsState();

  List<Object> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

// When app successfully loads album, this state will be used to update the UI
class AlbumsFetched extends AlbumsState {
  const AlbumsFetched({this.album, this.attr});

  final List<Album>? album;
  final Attr? attr;

  @override
  List<Object> get props => [album!, attr!];
}

// Use AlbumDetailLoaded to update the UI accordingly
class AlbumDetailLoaded extends AlbumsState {
  const AlbumDetailLoaded({
    required this.albumData,
    this.albumExists = false,
  });

  final AlbumData albumData;
  final bool albumExists;

  @override
  List<Object> get props => [albumData, albumExists];
}
