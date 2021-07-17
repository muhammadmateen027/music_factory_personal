part of 'search_artist_bloc.dart';

// enum SearchArtistStatus { initial, success, failure }

@immutable
abstract class ArtistState {

  const ArtistState();

  List<Object> get props => [];
}

class SearchArtistInitial extends ArtistState {}

class SearchArtistLoading extends ArtistState {}

class ArtistsListEnds extends ArtistState {}

class SearchArtistFailure extends ArtistState {
  const SearchArtistFailure(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class ArtistsLoadedState extends ArtistState {
  const ArtistsLoadedState({
    this.query,
    this.artists,
    this.currentPage,
    this.reachedMaximum = false,
  });

  final String? query;
  final List<Artist>? artists;
  final int? currentPage;
  final bool reachedMaximum;

  @override
  List<Object> get props => [query!, artists!, currentPage!, reachedMaximum];
}

class NoMoreArtists extends ArtistState {}
