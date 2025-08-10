// ignore_for_file: deprecated_member_use

import 'package:carely/models/booking_model.dart';
import 'package:carely/models/review_model.dart';
import 'package:carely/providers/caregiver_profile_provider.dart';
import 'package:carely/providers/seeker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenCg extends StatefulWidget {
  const HomeScreenCg({super.key});

  @override
  State<HomeScreenCg> createState() => _HomeScreenCgState();
}

class _HomeScreenCgState extends State<HomeScreenCg> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Booking> upcomingBookings = [];
  List<Booking> pendingRequests = [];
  List<Review> reviews = [
    Review(
      clientName: 'David Wilson',
      careGiverId: '',
      reviewText:
          'Emily is absolutely wonderful with my mother. Her patience and expertise make all the difference.',
      rating: 5.0,
      timeAgo: DateTime.now(),
    ),
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CaregiverProfileProvider>(
        context,
        listen: false,
      ).fetchCaregiverProfile();
      _fetchBookings();
    });
  }

  Future<void> _fetchBookings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        // Fetch confirmed bookings
        final confirmedSnapshot =
            await _firestore
                .collection('bookings')
                .where('caregiverId', isEqualTo: userId)
                .where('status', isEqualTo: 'confirmed')
                .get();

        // Fetch pending bookings
        final pendingSnapshot =
            await _firestore
                .collection('bookings')
                .where('caregiverId', isEqualTo: userId)
                .where('status', isEqualTo: 'pending')
                .get();

        final confirmed = await _processBookings(confirmedSnapshot);
        final pending = await _processBookings(pendingSnapshot);

        setState(() {
          upcomingBookings = confirmed;
          pendingRequests = pending;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<Booking>> _processBookings(QuerySnapshot snapshot) async {
    List<Booking> bookings = [];
    SeekerProfileProvider seekerProvider = Provider.of<SeekerProfileProvider>(
      context,
      listen: false,
    );

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final seekerId = data['seekerId'];

      // Fetch seeker profile to get their name and other details
      await seekerProvider.fetchSeekerProfileById(seekerId);
      final seekerProfile = seekerProvider.profile;

      if (seekerProfile != null) {
        final booking = Booking.fromMap(data);
        bookings.add(booking);
      }
    }

    return bookings;
  }

  String _formatBookingDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<CaregiverProfileProvider>(
          builder: (context, snapshot, _) {
            final profile = snapshot.profile;
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profile?.profileImageUrl ?? ''),
                  radius: 18,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back,',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          profile?.fullName ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Image.asset('assets/verified.png', height: 16),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick menu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickMenuItem(
                            context,
                            Icons.calendar_today_outlined,
                            'My Schedule',
                            () {
                              Navigator.pushNamed(context, '/schedule');
                            },
                            Colors.blue,
                          ),
                          _buildQuickMenuItem(
                            context,
                            Icons.person_outline,
                            'Edit Profile',
                            () {},
                            Colors.blue,
                          ),
                          _buildQuickMenuItem(
                            context,
                            Icons.message_outlined,
                            'Messages',
                            () {},
                            Colors.blue,
                          ),
                          _buildQuickMenuItem(
                            context,
                            Icons.star_outline,
                            'My Reviews',
                            () {},
                            Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // My Bookings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'My Bookings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/bookings');
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'View all',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      upcomingBookings.isEmpty
                          ? _buildEmptyState('No upcoming bookings')
                          : Column(
                            children:
                                upcomingBookings
                                    .map(
                                      (booking) =>
                                          _buildBookingCard(context, booking),
                                    )
                                    .toList(),
                          ),
                      const SizedBox(height: 24),

                      // Pending Requests
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pending Requests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (pendingRequests.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${pendingRequests.length}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      pendingRequests.isEmpty
                          ? _buildEmptyState('No pending requests')
                          : Column(
                            children:
                                pendingRequests
                                    .map(
                                      (request) => _buildPendingRequestCard(
                                        context,
                                        request,
                                      ),
                                    )
                                    .toList(),
                          ),
                      const SizedBox(height: 24),

                      // Recent Reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Reviews',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '4.9',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      reviews.isEmpty
                          ? _buildEmptyState('No reviews yet')
                          : Column(
                            children:
                                reviews
                                    .map(
                                      (review) =>
                                          _buildReviewCard(context, review),
                                    )
                                    .toList(),
                          ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      child: Column(
        children: [
          Icon(Icons.hourglass_empty, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
    Color iconColor,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Booking booking) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('seekers').doc(booking.seekerId).get(),
      builder: (context, snapshot) {
        String clientName = 'Loading...';
        String clientImageUrl = 'assets/default_user.png';
        String clientAddress = '';

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          clientName = data['fullName'] ?? 'Client';
          clientImageUrl = data['profileImageUrl'] ?? 'assets/default_user.png';
          clientAddress = data['location'];
        }

        return Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(clientImageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          booking.serviceType,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.event, size: 16, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    '${_formatBookingDate(booking.date)}, ${booking.time}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FutureBuilder<DocumentSnapshot>(
                      future:
                          _firestore
                              .collection('addresses')
                              .doc(booking.seekerId)
                              .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.exists) {
                        }
                        return Text(
                          clientAddress,
                          style: TextStyle(color: Colors.grey[700]),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    elevation: 0,
                  ),
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPendingRequestCard(BuildContext context, Booking request) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('seekers').doc(request.seekerId).get(),
      builder: (context, snapshot) {
        String clientName = 'Loading...';
        String clientImageUrl = 'assets/default_user.png';
        String clientAddress = '';

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          clientName = data['fullName'] ?? 'Client';
          clientImageUrl = data['profileImageUrl'] ?? 'assets/default_user.png';
          clientAddress = data['location'] ?? '';
        }

        return Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(clientImageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          request.serviceType,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.event, size: 16, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    '${_formatBookingDate(request.date)}, ${request.time}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FutureBuilder<DocumentSnapshot>(
                      future:
                          _firestore
                              .collection('addresses')
                              .doc(request.seekerId)
                              .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.exists) {
                        }
                        return Text(
                          clientAddress,
                          style: TextStyle(color: Colors.grey[700]),
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (request.notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '"${request.notes}"',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _updateBookingStatus(request.id ?? '', 'confirmed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Accept'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _updateBookingStatus(request.id ?? '', 'declined');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red,
                        elevation: 0,
                      ),
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateBookingStatus(String bookingId, String status) async {
    if (bookingId.isEmpty) return;

    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': status,
      });

      // Refresh bookings after status update
      _fetchBookings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update booking status')),
      );
    }
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.clientName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < review.rating ? Colors.amber : Colors.grey[300],
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(review.reviewText, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text(
            review.timeAgo.toIso8601String(),
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
