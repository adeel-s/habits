
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:habits/services/auth/auth_provider.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc(AuthProvider provider) : super(AuthStateUninitialized(isLoading: true)) {
    
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      emit(AuthStateRegistering(exception: null, isLoading: false));
      // final user = provider.currentUser;
      // if (user == null) {
      //   emit(const AuthStateLoggedOut(exception: null, isLoading: false,));
      // }
    });

    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(email: email, password: password,);
      } on Exception catch (e) {
        log(e.toString());
      }
    });
    
    // on<AuthEventShouldRegister>((event, emit) {
    //   emit (const AuthStateRegistering(exception: null, isLoading: false));
    // });
  }
}