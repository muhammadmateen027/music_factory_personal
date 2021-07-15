part of 'search_artist_bloc.dart';

enum SearchArtistStatus { initial, success, failure }

class SearchArtistState extends Equatable {
  const SearchArtistState({
    this.status = SearchArtistStatus.initial,
    this.artists = const <Artist>[],
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.totalResult = 0,
  });

  final SearchArtistStatus status;
  final List<Artist> artists;
  final bool hasReachedMax;
  final int currentPage;
  final int totalResult;

  SearchArtistState copyWith({
    SearchArtistStatus? status,
    List<Artist>? artists,
    bool? hasReachedMax,
    int? currentPage,
    int? totalResult,
  }) {
    return SearchArtistState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalResult: totalResult ?? this.totalResult,
    );
  }

  @override
  List<Object> get props => [
        status,
        artists,
        hasReachedMax,
        currentPage,
        totalResult,
      ];
}
