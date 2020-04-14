import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {
  
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LoginFailure { error: $message }';
}
