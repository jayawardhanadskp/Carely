import 'package:carely/models/booking_model.dart';
import 'package:carely/models/caregiver_model.dart';
import 'package:carely/models/seeker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream to fetch bookings
  Stream<List<Booking>> getBookings() {
    return _db
        .collection('bookings')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        Booking.fromMap(doc.data() as Map<String, dynamic>),
                  )
                  .toList(),
        );
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
}
