import 'package:carely/models/booking_model.dart';
import 'package:carely/services/booking_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  // Fetch bookings
  Stream<List<Booking>> getBookings() {
    return _firestore
        .collection('bookings')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Booking>> getBookingsByStatus(String caregiverId, String status) {
    return _firestore
        .collection('bookings')
        .where('caregiverId', isEqualTo: caregiverId)
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Booking.fromMap(doc.data()))
              .toList();
        });
  }

  Stream<List<Booking>> getBookingsForSeeker(String seekerId) {
    return _firestore
        .collection('bookings')
        .where('seekerId', isEqualTo: seekerId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Booking.fromMap(doc.data()))
              .toList();
        });
  }

  // Add a new booking
  Future<void> addBooking(Booking booking) async {
    await _firestoreService.addBooking(booking);
    getBookings();
  }
}
