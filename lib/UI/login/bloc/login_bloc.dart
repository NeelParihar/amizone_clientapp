import 'dart:async';

import 'package:amizone_clientapp/Remote/Repositories/auth_repository.dart';
import 'package:amizone_clientapp/auth/authbloc_bloc.dart';
import 'package:amizone_clientapp/auth/authbloc_event.dart';
import 'package:amizone_clientapp/UI/login/bloc/login_state.dart';
import 'package:amizone_clientapp/UI/login/bloc/login_event.dart';
import 'package:bloc/bloc.dart';
import 'package:amizone_clientapp/failure.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authBloc;

  LoginBloc(this.authRepository, this.authBloc);

  @override
  get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      try {
        final  token = await authRepository.login(event.login);
        yield LoginSuccess();
        authBloc.add(LoggedIn(token.token));
      } on Failure catch (failure) {
        yield LoginFailure(failure.message);
      }
    }
  }
}
