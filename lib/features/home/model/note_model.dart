import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String uid;
  final String note;
  final DateTime? createdAt;

  NoteModel({
    required this.id,
    required this.uid,
    required this.note,
    this.createdAt,
  });

  /// From Firestore Document to Model
  factory NoteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      note: data['note'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert Model to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'note': note,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
