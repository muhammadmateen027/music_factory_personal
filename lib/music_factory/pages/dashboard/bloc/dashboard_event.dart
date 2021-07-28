part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();

  List<Object> get props => [];
}

// This event will take [Artist] as a param and will pass to the bloc
class LoadAlbums extends DashboardEvent {}
