import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/auth_exceptions.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';
import 'package:habits/utilities/dialogs/error_dialog.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        if (state is AuthStateSignedOut) {
          if (state.exception is UserNotFoundAuthException ||
              state.exception is InvalidCredentialException) {
            await showErrorDialog(context, 'No user with those credentials');
          } else if (state.exception is InvalidEmailFormatException) {
            await showErrorDialog(context, 'Invalid email format');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Here is the body of the page'),
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
                  context.read<AuthBloc>().add(AuthEventSignIn(
                        email: email,
                        password: password,
                      ));
                },
                child: Text('sign in'),
                //remove splash/shadow effect here
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventShouldRegister(),
                      );
                },
                child: const Text('Register here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
