// ignore_for_file: deprecated_member_use

import 'package:carely/features/service_seeker/widgets/caregiver_card_widget_ss.dart';
import 'package:carely/models/caregiver_model.dart';
import 'package:carely/providers/caregivers_list_provider.dart';
import 'package:carely/providers/seeker_profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreenSs extends StatefulWidget {
  final Function(int)? onTabSelected;
  const HomeScreenSs({super.key, this.onTabSelected});

  @override
  State<HomeScreenSs> createState() => _HomeScreenSsState();
}

class _HomeScreenSsState extends State<HomeScreenSs> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SeekerProfileProvider>(
        context,
        listen: false,
      ).fetchSeekerProfile();

      Provider.of<CaregiversListProvider>(
        context,
        listen: false,
      ).fetchCaregivers();
    });
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
    } catch (e) {
      // print("Error fetching caregiver profile: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Consumer<SeekerProfileProvider>(
          builder: (context, snapshot, _) {
            final profile = snapshot.profile;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hi, ${profile?.fullName} ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text('👋', style: TextStyle(fontSize: 22)),
                  ],
                ),
                Text(
                  'Welcome back to Carely',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.grey[700],
                  size: 28,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Consumer<SeekerProfileProvider>(
            builder: (context, snapshot, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child:
                    snapshot.profile?.profileImageUrl != null
                        ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            snapshot.profile!.profileImageUrl!,
                          ),
                        )
                        : CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNextBookingCard(context),
              const SizedBox(height: 24),
              _buildQuickActionsGrid(),
              const SizedBox(height: 24),
              _buildSuggestedCaregivers(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextBookingCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Next Booking',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future:
              FirebaseFirestore.instance
                  .collection('bookings')
                  .where(
                    'seekerId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .where('status', whereIn: ['pending', 'confirmed'])
                  .orderBy('date')
                  .limit(1)
                  .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No bookings found.'));
            }

            final doc = snapshot.data!.docs.first;
            final booking = doc.data();
            final caregiverId = booking['caregiverId'];

            return FutureBuilder<CaregiverProfile?>(
              future: _fetchCaregiverProfileById(caregiverId),
              builder: (context, caregiverSnapshot) {
                if (caregiverSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final caregiver = caregiverSnapshot.data;

                String formatBookingDate(dynamic dateValue) {
                  if (dateValue is Timestamp) {
                    return DateFormat(
                      'MMMM dd, yyyy',
                    ).format(dateValue.toDate());
                  } else if (dateValue is String) {
                    try {
                      return DateFormat(
                        'MMMM dd, yyyy',
                      ).format(DateTime.parse(dateValue));
                    } catch (e) {
                      return 'Invalid Date';
                    }
                  } else if (dateValue is DateTime) {
                    return DateFormat('MMMM dd, yyyy').format(dateValue);
                  }
                  return 'Unknown Date';
                }

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            caregiver?.profileImageUrl != null
                                ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    caregiver!.profileImageUrl!,
                                  ),
                                )
                                : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '5.0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                caregiver?.fullName ?? 'Caregiver Name',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                caregiver?.bio ?? 'Home Care Specialist',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    formatBookingDate(booking['date']),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),

                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${booking['time']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      booking['status'] ?? 'Confirmed',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/seeker/bookingDetails',
                                      );
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          'View Details',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid() {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Find Caregiver',
        'icon': Icons.search,
        'color': Colors.blue.withOpacity(0.1),
        'iconColor': Colors.blue,
        'router': () => widget.onTabSelected?.call(2),
      },
      {
        'title': 'My Bookings',
        'icon': Icons.calendar_today,
        'color': Colors.purple.withOpacity(0.1),
        'iconColor': Colors.purple,
        'router': () => widget.onTabSelected?.call(1),
      },
      {
        'title': 'Messages',
        'icon': Icons.chat_bubble_outline,
        'color': Colors.green.withOpacity(0.1),
        'iconColor': Colors.green,
        'router': () => Navigator.pushNamed(context, '/seeker/chatList'),
      },
      {
        'title': 'Upload Medical info',
        'icon': Icons.description_outlined,
        'color': Colors.amber.withOpacity(0.1),
        'iconColor': Colors.amber[700],
        'router': () => {},
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              actions.map((action) {
                return GestureDetector(
                  onTap: action['router'],
                  child: SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: action['color'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            action['icon'],
                            color: action['iconColor'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          action['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildSuggestedCaregivers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suggested for You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Consumer<CaregiversListProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }

            final caregivers = provider.caregivers;

            final caregiversToShow =
                caregivers.length > 3 ? caregivers.sublist(0, 3) : caregivers;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: caregiversToShow.length,
              itemBuilder: (context, index) {
                final caregiver = caregivers[index];
                return CaregiverCardSs(
                  name: caregiver.fullName,
                  imageUrl: caregiver.profileImageUrl,
                  specialty: caregiver.qualifications,
                  rating: 4.8,
                  onViewProfile: () {
                    Navigator.pushNamed(
                      context,
                      '/seeker/caregiverProView',
                      arguments: caregiver,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
