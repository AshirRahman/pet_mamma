import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class HomeController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final noteController = TextEditingController();

  /// Current User Info
  User? get currentUser => _auth.currentUser;

  String get userName => currentUser?.displayName ?? "Anonymous User";
  String get userEmail => currentUser?.email ?? "Unknown Email";
  String? get userPhoto => currentUser?.photoURL;
  DateTime? get createdAt => currentUser?.metadata.creationTime;

  /// Stream of notes
  Stream<QuerySnapshot> get userNotes {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.empty();

    return _firestore
        .collection('notes')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Add new note
  Future<void> addNote() async {
    final uid = _auth.currentUser?.uid;
    final text = noteController.text.trim();
    if (uid == null || text.isEmpty) return;

    await _firestore.collection('notes').add({
      'uid': uid,
      'note': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
    noteController.clear();
  }

  /// Delete note
  Future<void> deleteNote(String docId) async {
    await _firestore.collection('notes').doc(docId).delete();
  }

  /// Sign out and navigate to login
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }
}
