part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState{}
class DashboardSuccess extends DashboardState {
  final List<Attendance> users;

  DashboardSuccess(this.users);

  List<Object> get props => [users];
}
class DashboardFailure extends DashboardState{
  final String message;

  DashboardFailure(this.message);

  List<Object> get props => [message];
}
