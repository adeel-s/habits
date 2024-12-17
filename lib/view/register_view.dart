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
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'email',
                ),
                controller: _emailController,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                ),
                controller: _passwordController,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
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
                //remove splash/shadow effect here
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSignOut(),
                      );
                },
                child: Text('sign in'),
                //remove splash/shadow effect here
              )
            ],
          ),
        ),
      ),
    );
  }
}
