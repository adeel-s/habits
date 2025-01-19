import 'package:flutter/material.dart';
import 'package:habits/services/cloud/habit.dart';

//this is a doohickey used to send delete requests back to the notes_view file
typedef HabitCallback = void Function(Habit note);

class HabitsListView extends StatelessWidget {
  final Iterable<Habit> habits;
  //final NoteCallback onDeleteNote;
  //final NoteCallback onTap;
  const HabitsListView({
    super.key,
    required this.habits,
    // required this.onDeleteNote,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits.elementAt(index);
          {
            return ListTile(
              title: Text(habit.activity),
              subtitle: Text('${habit.time.hour}:${habit.time.minute}'),
              trailing: Checkbox(
                value: false,
                onChanged: (bool? newValue) {
                  false;
                },
              ),
              //TODO: Add more habit fields here after you see the two currently in the database
              // onTap: () {
              //   onTap(habit);
              // },
              // trailing: IconButton(
              //   onPressed: () async {
              //     final shouldDelete = await showDeleteDialog(context);
              //     if (shouldDelete) {
              //       onDeleteNote(note);
              //     }
              //   },
              //   icon: Icon(Icons.delete),
              // ),
            );
          }
        });
  }
}
