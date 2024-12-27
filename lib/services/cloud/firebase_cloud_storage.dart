import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/services/cloud/cloud_storage_constants.dart';
import 'package:habits/services/cloud/cloud_storage_exceptions.dart';
import 'package:habits/services/cloud/habit.dart';

class FirebaseCloudStorage {
  final habits = FirebaseFirestore.instance.collection('habits');

  Future<void> deleteHabit({required String documentId}) async {
    try {
      await habits.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateHabit({
    required String documentId,
    required String activity,
    required DateTime time,
    required String description,
  }) async {
    try {
      await habits.doc(documentId).update({activityField: activity});
      await habits.doc(documentId).update({timeField: time});
      await habits.doc(documentId).update({descriptionField: description});
      
    } catch (e) {
      CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<Habit>> allHabits({required String ownerUserId}) {
    final allHabits = habits
        .where(userIdField, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => Habit.fromSnapshot(doc)));
    return allHabits;
  }

  Future<Habit> createHabit({required String ownerUserId}) async {
    final document = await habits.add({
      userIdField: ownerUserId,
      activityField: '',
      timeField: DateTime.utc(2025, 1, 1),
      descriptionField: '',
    });
    final fetchedHabit = await document.get();
    return Habit(
      documentId: fetchedHabit.id,
      userId: ownerUserId,
      activity: '',
      time: DateTime.utc(2025, 1, 1), 
      description: '',

    );
  }

  //Forces instantializations to return the same instance of a FirebaseCloudStorage. "singleton"
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
