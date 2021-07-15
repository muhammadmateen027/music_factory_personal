part of 'search_artist_bloc.dart';

@immutable
abstract class SearchArtistState {
  const SearchArtistState();

List<Object> get props => [];
}

class SearchArtistInitial extends SearchArtistState {}
class ArtistsLoading extends SearchArtistState {}

class SearchArtist extends SearchArtistState {
  const SearchArtist(this.query);

  final String query;
  @override
  List<Object> get props => [query];
}

class ArtistsLoaded extends SearchArtistState {
  const ArtistsLoaded(this.artists);

  final List<Artist> artists;

  @override
  List<Object> get props => [artists];
}
