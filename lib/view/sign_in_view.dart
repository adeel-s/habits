import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in'),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column (children: [
        Text('Here is the body of the page')
      ],
      ),
      ),
    );
  }
}