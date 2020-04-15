part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}
class ScheduleLoading extends ScheduleState{}
class ScheduleSuccess extends ScheduleState {
  final List<Schedule> users;

  ScheduleSuccess(this.users);

  List<Object> get props => [users];
}
class ScheduleFailure extends ScheduleState{
  final String message;

  ScheduleFailure(this.message);

  List<Object> get props => [message];
}
