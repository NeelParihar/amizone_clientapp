import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeScreen();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomePageSelected) {
      yield HomeScreen();
    }

    if (event is SchedulePageSelected) {
      yield HomeScreenSchedule();
    }

    if (event is AssignmentsPageSelected) {
      yield HomeScreenAssignments();
    }
  }
}
