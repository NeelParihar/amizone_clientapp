import 'package:amizone_clientapp/Remote/Repositories/auth_repository.dart';
import 'package:amizone_clientapp/UI/home/Home.dart';
import 'package:amizone_clientapp/UI/login/loginPage.dart';
import 'package:amizone_clientapp/auth/authbloc_bloc.dart';
import 'package:amizone_clientapp/auth/authbloc_event.dart';
import 'package:amizone_clientapp/auth/authbloc_state.dart';

import 'package:logging/logging.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';


/// BlocDelegate which logs all BLOC events, errors and transitions.
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Logger.root.info(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Logger.root.severe(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.root.info(transition);
  }
}
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  _setupLogging();

  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(authRepository:AuthRepository.instance)..add(AppStarted()),
      child: App(),
    ));
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          if (state.justLoggedOut) {
            Toast.show("Logged out", context, duration: 1);
          }
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.orangeAccent,
          primaryColor: Colors.indigo
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state){
            assert(state != null);
            if (state is AuthenticationUnauthenticated) {
              return LoginScreen();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            } 
            else{
                 return Scaffold();
            }
          },
        ),
      ),
    );
  }
}
