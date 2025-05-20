import 'package:carely/models/caregiver_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverProfileProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CaregiverProfile? _profile;
  bool _isLoading = false;

  CaregiverProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchCaregiverProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('caregivers')
                .doc(user.uid)
                .get();
        if (doc.exists) {
          _profile = CaregiverProfile.fromMap(doc.data()!);
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error fetching caregiver profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<CaregiverProfile?> fetchCaregiverProfileById(
    String caregiverId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('caregivers')
              .doc(caregiverId)
              .get();
      if (doc.exists) {
        _profile = CaregiverProfile.fromMap(doc.data()!);
      }
    } catch (e) {
      print("Error fetching caregiver profile: $e");
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }
}
