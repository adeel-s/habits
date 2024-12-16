import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('Register'),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column (children: [
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
          decoration: InputDecoration(
            hintText: 'password',
          ),
          controller: _passwordController,
          autocorrect: false,
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
        ),
        TextButton(onPressed: () {

        }, 
        child: Text('register'),
        //remove splash/shadow effect here
        ),
        TextButton(onPressed: () {

        }, 
        child: Text('sign in'),
        //remove splash/shadow effect here
        )
      ],
      ),
      ),
    );
  }
}