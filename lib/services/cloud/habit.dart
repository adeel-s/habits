import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/services/cloud/cloud_storage_constants.dart';

class Habit {
  final String documentId;
  final String userId;
  final String activity;
  final DateTime time;
  //final String frequency;
  //final String location;
  //final String successCriteria;
  final String description;
  //final String trigger;

  const Habit({
    required this.documentId,
    required this.userId,
    required this.activity,
    required this.time,
    required this.description,
  });

  Habit.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        userId = snapshot.data()[userIdField],
        activity = snapshot.data()[activityField] as String,
        time = snapshot.data()[timeField].toDate() as DateTime,
        description = snapshot.data()[descriptionField] as String;
}
