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

  //Figure out what this does...
  // Habit.fromSnapshot(QueryDocumentSnapshot <Map<String, dynamic>> snapshot)
  // : documentId = snapshot.id,
  // userId = snapshot.data()[ownerUserIdFieldName],
}
