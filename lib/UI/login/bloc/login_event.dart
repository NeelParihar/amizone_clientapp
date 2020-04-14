import 'package:amizone_clientapp/Remote/Requests/login.dart';

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
   LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Login login;

   LoginButtonPressed(this.login);

  @override
  List<Object> get props => [login];
}
