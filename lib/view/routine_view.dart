import 'package:flutter/material.dart';

class RoutinesView extends StatefulWidget {
  const RoutinesView({super.key});

  @override
  State<RoutinesView> createState() => _RoutinesViewState();
}

class _RoutinesViewState extends State<RoutinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Routines'),
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