// ignore_for_file: library_private_types_in_public_api

import 'package:carely/models/booking_model.dart';
import 'package:carely/models/caregiver_model.dart';
import 'package:carely/features/service_seeker/widgets/booking_card_widget_ss.dart';
import 'package:carely/providers/booking_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingsScreenSs extends StatefulWidget {
  const BookingsScreenSs({super.key});

  @override
  _BookingsScreenSsState createState() => _BookingsScreenSsState();
}

class _BookingsScreenSsState extends State<BookingsScreenSs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Upcoming', 'Past'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seekerId = FirebaseAuth.instance.currentUser!.uid;
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF2563EB),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                tabs: tabs.map((String name) => Tab(text: name)).toList(),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Booking>>(
        stream: bookingProvider.getBookingsForSeeker(seekerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading bookings: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          final allBookings = snapshot.data!;
          final now = DateTime.now();

          final upcomingBookings =
              allBookings.where((b) {
                return (b.date.isBefore(now) || b.date.isAtSameMomentAs(now)) &&
                    (b.status == 'pending' || b.status == 'confirmed');
              }).toList();

          final pastBookings =
              allBookings.where((b) {
                return (b.date.isAfter(now)) && b.status == 'completed';
              }).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookingList(upcomingBookings),
              _buildBookingList(pastBookings),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookingList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const Center(child: Text('No bookings to show.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return FutureBuilder<CaregiverProfile?>(
          future: _fetchCaregiverProfileById(booking.caregiverId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final caregiver = snapshot.data;

            return BookingCardSs(
              caregiverId: booking.caregiverId,
              imageUrl: caregiver?.profileImageUrl ?? '',
              caregiverName: caregiver?.fullName ?? 'Caregiver',
              caregiverRating: 4.0,
              date: booking.date.toLocal().toString().split(' ')[0],
              time: booking.time,
              location: 'Home',
              status: _mapStatusToEnum(booking.status),
            );
          },
        );
      },
    );
  }

  Future<CaregiverProfile?> _fetchCaregiverProfileById(
    String caregiverId,
  ) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('caregivers')
              .doc(caregiverId)
              .get();
      if (doc.exists) {
        return CaregiverProfile.fromMap(doc.data()!);
      }
    // ignore: empty_catches
    } catch (e) {
    }
    return null;
  }

  BookingStatus _mapStatusToEnum(String status) {
    switch (status) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'pending':
        return BookingStatus.pending;
      case 'completed':
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }
}
