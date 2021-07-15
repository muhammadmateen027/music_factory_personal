import 'package:bloc/bloc.dart';
import 'package:music_factory/repository/repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.musicService}) : super(DashboardInitial()) {
    on<LoadAlbums>(_loadAlbums);
  }
  final MusicService musicService;

  void _loadAlbums(LoadAlbums event, Emit<DashboardState> emit) async {
    emit(DashboardLoading());

    emit(const AlbumLoaded(artist: ''));
  }
}
