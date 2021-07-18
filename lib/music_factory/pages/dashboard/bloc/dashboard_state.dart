part of 'dashboard_bloc.dart';

abstract class DashboardState {
  const DashboardState();

  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class EmptyAlbums extends DashboardState {}

class DashboardLoading extends DashboardState {}

class AlbumLoaded extends DashboardState {
  const AlbumLoaded({required this.albums});

  final List<Album> albums;

  @override
  List<Object> get props => [albums];
}

class AlbumExistState extends DashboardState {}

class AlbumNotExistState extends DashboardState {}
