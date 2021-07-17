part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();

  List<Object> get props => [];
}

class LoadAlbums extends DashboardEvent {}

class SaveAlbum extends DashboardEvent {
  const SaveAlbum(this.album);
  final Album album;

  @override
  List<Object> get props => [album];
}

class LoadAlbumDetail extends DashboardEvent {
  const LoadAlbumDetail(this.album);
  final Album album;

  @override
  List<Object> get props => [album];
}
