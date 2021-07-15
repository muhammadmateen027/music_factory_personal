part of 'search_artist_bloc.dart';

@immutable
abstract class SearchArtistEvent {
  const SearchArtistEvent();

  List<Object> get props => [];
}

class SearchArtists extends SearchArtistEvent {}
