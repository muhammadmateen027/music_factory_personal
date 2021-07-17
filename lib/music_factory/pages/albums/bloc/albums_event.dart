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
