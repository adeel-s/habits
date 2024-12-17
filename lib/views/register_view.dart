import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/auth_exceptions.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';
import 'package:habits/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  //dispose of variables when this page is no longer used
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is InvalidEmailFormatException) {
            await showErrorDialog(context, 'Invalid email format');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ImageIcon(AssetImage('assets/icons/refresh.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'habits',
                    textScaler: TextScaler.linear(2),
                  ),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                      controller: _emailController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xFF3E465C),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none),
                        hintText: 'email',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xFF3E465C),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none),
                        hintText: 'password',
                      )),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context.read<AuthBloc>().add(AuthEventRegister(
                        email: email,
                        password: password,
                      ));
                },
                child: Text('register'),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFACAFB5),
                  backgroundColor: Colors.transparent,
                ),
              ),
              //remove splash/shadow effect here
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSignOut(),
                      );
                },
                child: Text('sign in here'),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFACAFB5),
                  backgroundColor: Colors.transparent,
                ),
                //remove splash/shadow effect here
              )
            ],
          ),
        ),
      ),
    );
  }
}
