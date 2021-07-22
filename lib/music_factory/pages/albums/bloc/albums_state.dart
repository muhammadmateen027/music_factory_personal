part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {
  const AlbumsState();

  List<Object> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class TopTagsLoaded extends AlbumsState {
  const TopTagsLoaded({this.album, this.attr});

  final List<Album>? album;
  final Attr? attr;


  @override
  List<Object> get props => [album!, attr!];
}
