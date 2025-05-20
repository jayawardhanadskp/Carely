import 'package:carely/models/caregiver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CaregiversListProvider with ChangeNotifier {
  List<CaregiverProfile> _caregivers = [];
  bool _isLoading = false;
  String? _error;

  List<CaregiverProfile> get caregivers => _caregivers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch caregivers from Firestore
  Future<void> fetchCaregivers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('caregivers')
          .get();

      _caregivers = snapshot.docs.map((doc) {
        final data = doc.data();
        return CaregiverProfile.fromMap(data,);
      }).toList();
    } catch (e) {
      _error = 'Failed to load caregivers. Please try again.';
      debugPrint('Error fetching caregivers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _caregivers = [];
    _error = null;
    notifyListeners();
  }
}
