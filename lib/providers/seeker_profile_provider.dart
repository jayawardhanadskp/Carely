import 'package:carely/models/seeker_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeekerProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SeekerProfile? _profile;
  bool _isLoading = false;

  SeekerProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchSeekerProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('seekers').doc(user.uid).get();
        if (doc.exists) {
          _profile = SeekerProfile.fromMap(doc.data()!);
        }
      }
    } catch (e) {
      print("Error fetching seeker profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSeekerProfileById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final doc = await _firestore.collection('seekers').doc(id).get();
      if (doc.exists) {
        _profile = SeekerProfile.fromMap(doc.data()!);
      }
    } catch (e) {
      print("Error fetching seeker profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
