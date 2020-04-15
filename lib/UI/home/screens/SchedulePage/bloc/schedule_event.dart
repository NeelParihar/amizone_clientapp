part of 'schedule_bloc.dart';



@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  List<Object> get props => [];
}

class ScheduleShowed extends ScheduleEvent {}
