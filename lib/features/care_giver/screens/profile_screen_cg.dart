// ignore_for_file: deprecated_member_use

import 'package:carely/providers/caregiver_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenCg extends StatefulWidget {
  const ProfileScreenCg({super.key});

  @override
  State<ProfileScreenCg> createState() => _ProfileScreenCgState();
}

class _ProfileScreenCgState extends State<ProfileScreenCg> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CaregiverProfileProvider>(
        context,
        listen: false,
      ).fetchCaregiverProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        centerTitle: true,
        title: const Text('Your Profile'),
      ),
      body: Consumer<CaregiverProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = provider.profile;
          // print(profile?.profileImageUrl ?? 'No image URL');

          if (profile == null) {
            return const Center(child: Text("Profile not found"));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        profile.profileImageUrl != null
                            ? NetworkImage(profile.profileImageUrl!)
                            : AssetImage('assets/user_avatar.png')
                                as ImageProvider,
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    profile.fullName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '4.8 (124 reviews)',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Bio
                  Text(
                    profile.bio,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Details Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    profile.gender ?? 'Not specified',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Experience',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    profile.yearsOfExperience,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              profile.location,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Qualifications',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildQualificationChip(profile.qualifications),
                            _buildQualificationChip('First Aid'),
                            _buildQualificationChip('Dementia Care'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Availability Status',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 10,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Available',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Availability Section
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.1),
                  //         spreadRadius: 1,
                  //         blurRadius: 5,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         'Availability',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 16),
                  //       // Day selection
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           _buildDayButton('Mon', false),
                  //           _buildDayButton('Tue', true),
                  //           _buildDayButton('Wed', true),
                  //           _buildDayButton('Thu', false),
                  //           _buildDayButton('Fri', false),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           _buildDayButton('Sat', false),
                  //           _buildDayButton('Sun', false),
                  //           const SizedBox(width: 40),
                  //           const SizedBox(width: 40),
                  //           const SizedBox(width: 40),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 24),
                  //       // Time slots
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           _buildTimeButton('9:00 AM'),
                  //           _buildTimeButton('11:00 AM'),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 16),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           _buildTimeButton('2:00 PM'),
                  //           _buildTimeButton('4:00 PM'),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 24),
                  // // Reviews
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.1),
                  //         spreadRadius: 1,
                  //         blurRadius: 5,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text(
                  //             'Reviews',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               // Handle view all reviews
                  //             },
                  //             child: Row(
                  //               children: const [
                  //                 Text(
                  //                   'View all',
                  //                   style: TextStyle(
                  //                     color: Colors.blue,
                  //                   ),
                  //                 ),
                  //                 Icon(
                  //                   Icons.chevron_right,
                  //                   color: Colors.blue,
                  //                   size: 16,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 16),
                  //       // Review 1
                  //       _buildReviewItem(
                  //         'Sarah Miller',
                  //         5,
                  //         'Emily took wonderful care of my mother. She was patient, kind, and professional. Would highly recommend!',
                  //         '2 weeks ago',
                  //       ),
                  //       const Divider(),
                  //       // Review 2
                  //       _buildReviewItem(
                  //         'Robert Chen',
                  //         4,
                  //         'Very reliable and my dad enjoys her company. She\'s always on time and communicates well.',
                  //         '1 month ago',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQualificationChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF3B82F6), fontSize: 12),
      ),
    );
  }



}
