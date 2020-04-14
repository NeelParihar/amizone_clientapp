import 'dart:async';

import 'package:amizone_clientapp/Remote/Models/attendance.dart';
import 'package:amizone_clientapp/Remote/Repositories/user_repository.dart';

import 'package:logging/logging.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:amizone_clientapp/failure.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  @override
  DashboardState get initialState => DashboardInitial();
  final UserRepository userRepository;
  DashboardBloc({@required this.userRepository}) : assert(userRepository != null);
  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    
    if (event is DashboardShowed) {
          yield DashboardLoading();
          try {
            final List<Attendance> attendance = await userRepository.getAllTasks();
            yield DashboardSuccess(attendance);
          } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield DashboardFailure(failure.message);
      }
        }
      }
    }
    
    
