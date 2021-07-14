part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();

  List<Object> get props => [];
}

class LoadAlbums extends DashboardEvent {}
