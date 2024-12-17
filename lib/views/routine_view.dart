import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/views/menu_action.dart';
import 'package:habits/utilities/dialogs/logout_dialog.dart';

class RoutinesView extends StatefulWidget {
  const RoutinesView({super.key});

  @override
  State<RoutinesView> createState() => _RoutinesViewState();
}

class _RoutinesViewState extends State<RoutinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routines'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(
                          AuthEventSignOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Sign out'),
                ),
              ];
            },
          )
        ],
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
