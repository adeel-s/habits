import 'package:flutter/material.dart';

class UnimplementedView extends StatefulWidget {
  const UnimplementedView({super.key});

  @override
  State<UnimplementedView> createState() => _UnimplementedViewState();
}

class _UnimplementedViewState extends State<UnimplementedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unimplemented'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [Text('Here is the body of the page')],
        ),
      ),
    );
  }
}
