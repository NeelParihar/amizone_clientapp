import 'dart:async';

import 'package:amizone_clientapp/Remote/Repositories/auth_repository.dart';
import 'package:amizone_clientapp/auth/authbloc_event.dart';
import 'package:amizone_clientapp/auth/authbloc_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final  AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final String token = await authRepository.getToken();

      if (token != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated(justLoggedOut: true);
    }
  }
}
