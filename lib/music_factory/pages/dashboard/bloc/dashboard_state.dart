part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();

  List<Object> get props => [];
}


class DashboardInitial extends DashboardState {}
class AlbumsLoaded extends DashboardState {
  const AlbumsLoaded({required this.albums});
  final List<AlbumData> albums;

  @override
  List<Object> get props => [albums];
}
