part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();

  List<Object> get props => [];
}

class LoadAlbums extends DashboardEvent {}
class TruncateTable extends DashboardEvent {}

class DeleteItem extends DashboardEvent {
  const DeleteItem(this.album);
  final Album album;

  @override
  List<Object> get props => [album];
}

class SaveAlbum extends DashboardEvent {
  const SaveAlbum(this.album);
  final Album album;

  @override
  List<Object> get props => [album];
}

class LoadButtonState extends DashboardEvent {
  const LoadButtonState(this.album);
  final Album album;

  @override
  List<Object> get props => [album];
}
