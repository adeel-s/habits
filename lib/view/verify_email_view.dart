import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify email'),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column (children: [
        Text('Here is the body of the page')
      ],
      ),
      ),
    );;
  }
}