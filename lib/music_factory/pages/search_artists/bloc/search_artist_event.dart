part of 'search_artist_bloc.dart';

@immutable
abstract class ArtistEvent {
  const ArtistEvent();

  List<Object> get props => [];
}

class SearchArtists extends ArtistEvent {
  const SearchArtists({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}

class LoadArtists extends ArtistEvent {}