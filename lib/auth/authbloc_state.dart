import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {
  final bool justLoggedOut;

  AuthenticationUnauthenticated({this.justLoggedOut=false});

  @override
  List<Object> get props => [justLoggedOut];
}

class AuthenticationLoading extends AuthenticationState {}
