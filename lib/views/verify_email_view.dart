import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify email'),
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
            Text(
              'a verification email has been sent,',
              textAlign: TextAlign.center,
            ),
            Text(
              'please verify your account',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
              },
              child: const Text('Send email verification'),
              //TODO: Add text widget when button is pressed to remind user to check their spam folder
            ),
            TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventSignOut(),
                    );
              },
              child: const Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
}
