part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  HomeEvent();
  factory HomeEvent.fromIndex(int index) {
    HomeEvent event;
    switch (index) {
      case 0:
        event = HomePageSelected();
        break;
      case 1:
        event = SchedulePageSelected();
        break;
      case 2:
        event = AssignmentsPageSelected();
        break;

      default:
      //Logger.root.shout("HomeEvent.fromIndex: index $index is not valid");
    }

    return event;
  }
}

class HomePageSelected extends HomeEvent {}

class SchedulePageSelected extends HomeEvent {}

class AssignmentsPageSelected extends HomeEvent {}
