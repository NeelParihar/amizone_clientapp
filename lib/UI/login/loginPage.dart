import 'package:amizone_clientapp/Remote/Repositories/auth_repository.dart';
import 'package:amizone_clientapp/Remote/Requests/login.dart';
import 'package:amizone_clientapp/UI/login/bloc/login_bloc.dart';
import 'package:amizone_clientapp/UI/login/bloc/login_event.dart';
import 'package:amizone_clientapp/UI/login/bloc/login_state.dart';
import 'package:amizone_clientapp/auth/authbloc_bloc.dart';
import 'package:amizone_clientapp/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(AuthRepository.instance,
            BlocProvider.of<AuthenticationBloc>(context)),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 100),
              Image.asset("assets/amizone-logo.png"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                      child: LoginForm(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  ProgressDialog pr;
  bool _passwordVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onLoginButtonPressed() {
    if (!_formKey.currentState.validate()) return;

    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        Login(
            username: _usernameController.text.trim(),
            password: _passwordController.text),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return "Username is empty";
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return "Password is empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        pr = ProgressDialog(
          context,
          type: ProgressDialogType.Normal,
          isDismissible: true,
        );

        pr.style(
          message: 'Logging in...',
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
        );
        if (state is LoginFailure) {
          setState(() {
            Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                context.showSnackBar(state.message);
                print(pr.isShowing());
              });
            });
          });
        }
        if (state is LoginSuccess) {
          setState(() {
            Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                context.toast("Login successful");
                print(pr.isShowing());
              });
            });
          });
        }
        if (state is LoginInProgress) {
          pr.show();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 12),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 25),
              TextFormField(
                controller: _usernameController,
                validator: _validateUsername,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.all(5), child: Icon(Icons.person)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    labelText: "Enter username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _passwordController,
                validator: _validatePassword,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.all(5), child: Icon(Icons.lock)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _togglePasswordVisibility,
                    ),
                    labelText: "Enter password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                obscureText: !_passwordVisible,
              ),
              SizedBox(height: 35),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).accentColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      splashColor: Theme.of(context).backgroundColor,
                      onPressed: state is! LoginInProgress
                          ? _onLoginButtonPressed
                          : null,
                      child: Text("LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
            ]));
      }),
    );
  }
}
