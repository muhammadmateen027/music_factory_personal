part of 'search_artist_bloc.dart';

@immutable
abstract class SearchArtistEvent {
  const SearchArtistEvent();

  List<Object> get props => [];
}

class SearchArtists extends SearchArtistEvent {
  const SearchArtists({this.query = ''});
  final String query;

  @override
  List<Object> get props => [query];
}
