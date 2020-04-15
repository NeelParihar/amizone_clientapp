import 'dart:async';

import 'package:amizone_clientapp/Remote/Models/Schedule.dart';
import 'package:amizone_clientapp/Remote/Models/attendance.dart';
import 'package:amizone_clientapp/Remote/Repositories/user_repository.dart';

import 'package:equatable/equatable.dart';

import 'package:logging/logging.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:amizone_clientapp/failure.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  @override
  ScheduleState get initialState => ScheduleInitial();
  final UserRepository userRepository;
  ScheduleBloc({@required this.userRepository}) : assert(userRepository != null);
  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    
    if (event is ScheduleShowed) {
          yield ScheduleLoading();
          try {
            final List<Schedule> schedule = await userRepository.getSchedule();
            yield ScheduleSuccess(schedule);
          } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield ScheduleFailure(failure.message);
      }
        }
      }
    }
    
    
