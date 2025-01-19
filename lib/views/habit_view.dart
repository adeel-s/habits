import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/services/auth/auth_service.dart';
import 'package:habits/services/auth/bloc/auth_bloc.dart';
import 'package:habits/services/auth/bloc/auth_event.dart';
import 'package:habits/services/cloud/firebase_cloud_storage.dart';
import 'package:habits/services/cloud/habit.dart';
import 'package:habits/views/habits_list_view.dart';
import 'package:habits/views/menu_action.dart';
import 'package:habits/utilities/dialogs/logout_dialog.dart';

class HabitView extends StatefulWidget {
  const HabitView({super.key});

  @override
  State<HabitView> createState() => _HabitViewState();
}

class _HabitViewState extends State<HabitView> {
  String get userId => AuthService.firebase().currentUser!.id;
  late final FirebaseCloudStorage _habitsService;

  @override
  void initState() {
    _habitsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habits'),
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
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder(
              stream: _habitsService.allHabits(ownerUserId: userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final allHabits = snapshot.data as Iterable<Habit>;
                      return HabitsListView(
                        habits: allHabits,
                      );
                    } else {
                      log(snapshot.connectionState.toString());
                      return const CircularProgressIndicator();
                    }

                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('view completed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
