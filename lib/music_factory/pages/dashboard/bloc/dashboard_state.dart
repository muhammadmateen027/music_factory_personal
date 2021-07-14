part of 'dashboard_bloc.dart';

abstract class DashboardState {
  const DashboardState();

  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class AlbumLoaded extends DashboardState {
  const AlbumLoaded({required this.artist});

  final String artist;

  @override
  List<Object> get props => [artist];

}
