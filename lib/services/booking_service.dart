import 'package:carely/models/booking_model.dart';
import 'package:carely/models/caregiver_model.dart';
import 'package:carely/models/seeker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream to fetch caregiver profiles
  Stream<List<CaregiverProfile>> getCaregivers() {
    return _db
        .collection('profiles')
        .where('role', isEqualTo: 'caregiver')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CaregiverProfile.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Stream to fetch seeker profiles
  Stream<List<SeekerProfile>> getSeekers() {
    return _db
        .collection('profiles')
        .where('role', isEqualTo: 'seeker')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SeekerProfile.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Stream to fetch bookings
  Stream<List<Booking>> getBookings() {
    return _db
        .collection('bookings')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Add a new booking
  Future<void> addBooking(Booking booking) async {
    try {
      final docRef = await _db.collection('bookings').add(booking.toMap());
      await docRef.update({'id': docRef.id}); 
    } catch (e) {
      debugPrint("Error adding booking: $e");
    }
  }

  // Update a profile's bookings
  Future<void> updateProfileBookings(String uid, List<String> bookingIds) async {
    try {
      await _db.collection('profiles').doc(uid).update({'bookings': bookingIds});
    } catch (e) {
      debugPrint("Error updating profile bookings: $e");
    }
  }

  
}
