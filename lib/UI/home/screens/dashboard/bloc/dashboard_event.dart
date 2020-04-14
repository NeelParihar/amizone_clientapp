part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  List<Object> get props => [];
}

class DashboardShowed extends DashboardEvent {}
