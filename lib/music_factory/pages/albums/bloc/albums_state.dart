part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {
  const AlbumsState();

  List<Object> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class SearchArtistLoading extends AlbumsState {}

class TopTagsLoaded extends AlbumsState {
  const TopTagsLoaded({this.topAlbumsModel});

  final TopAlbumsModel? topAlbumsModel;

  @override
  List<Object> get props => [topAlbumsModel!];
}
