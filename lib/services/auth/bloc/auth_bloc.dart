import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:habits/services/auth/auth_provider.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';
import 'package:habits/services/auth/firebase_auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(AuthStateUninitialized(isLoading: true)) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(AuthStateSignedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateSignedIn(user: user, isLoading: false));
      }

      // final user = provider.currentUser;
      // if (user == null) {
      //   emit(const AuthStateLoggedOut(exception: null, isLoading: false,));
      // }
    });

    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(
          AuthStateNeedsVerification(isLoading: false),
        );
      } on Exception catch (e) {
        emit(AuthStateRegistering(
          exception: e,
          isLoading: false,
        ));
      }
    });

    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
    });

    on<AuthEventSignIn>((event, emit) async {
      emit(const AuthStateSignedOut(
        exception: null,
        isLoading:
            true, //TODO: This is producing a long loading screen on exceptions...
        loadingText: 'Please wait...',
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.signIn(
          email: email,
          password: password,
        );
        if (!user.isVerified) {
          emit(
            const AuthStateSignedOut(
              exception: null,
              isLoading: false,
            ),
          );
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification(
            isLoading: false,
          ));
        } else {
          emit(const AuthStateSignedOut(
            exception: null,
            isLoading: false,
          ));
          emit(AuthStateSignedIn(
            user: user,
            isLoading: false,
          ));
        }
      } on Exception catch (e) {
        log('failed to sign in');
        log(e.toString());
        emit(
          AuthStateSignedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });

    on<AuthEventSignOut>((event, emit) async {
      try {
        await provider.signOut();
        emit(
          const AuthStateSignedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(AuthStateSignedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });

    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    // on<AuthEventShouldRegister>((event, emit) {
    //   emit (const AuthStateRegistering(exception: null, isLoading: false));
    // });
  }
}
