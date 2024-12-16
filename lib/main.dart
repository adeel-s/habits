import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/auth/bloc/auth_state.dart';
import 'package:habits/services/auth/firebase_auth_provider.dart';
import 'package:habits/view/register_view.dart';
import 'package:habits/view/routine_view.dart';
import 'package:habits/view/sign_in_view.dart';
import 'package:habits/view/verify_email_view.dart';

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
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create:(context) => AuthBloc(FirebaseAuthProvider()), 
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});


}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState> (
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen.hide();
        }
      },
      builder: (context, state){
        if(state is AuthStateRegistering) {
          return const RegisterView();
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
      
      

