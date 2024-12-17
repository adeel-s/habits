import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/helpers/loading/loading_screen.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';
import 'package:habits/services/auth/firebase_auth_provider.dart';
import 'package:habits/services/cloud/routine.dart';
import 'package:habits/themes/themes.dart';
import 'package:habits/views/register_view.dart';
import 'package:habits/views/routine_view.dart';
import 'package:habits/views/sign_in_view.dart';
import 'package:habits/views/unimplemented_view.dart';
import 'package:habits/views/verify_email_view.dart';

void main() {
  runApp(const HabitsApp());
}

class HabitsApp extends StatelessWidget {
  const HabitsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'habits',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        log(state.toString());
        if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateSignedOut) {
          return const SignInView();
        } else if (state is AuthStateSignedIn) {
          return const RoutinesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
