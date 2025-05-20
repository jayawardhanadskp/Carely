// import 'package:flutter/material.dart';

// class ProfileScreenCg extends StatelessWidget {
//   const ProfileScreenCg({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Your Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.favorite_border,
//               color: Colors.grey[400],
//             ),
//             onPressed: () {
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Profile Image
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/caregiver2.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Name
//               const Text(
//                 'Emily Johnson',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               // Rating
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     '4.8 (124 reviews)',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               // Bio
//               Text(
//                 'Compassionate caregiver with over 8 years of experience in elderly care and special needs. Specialized in dementia care and physical therapy assistance.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               // Details Section
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFEFF6FF),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Details',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Gender',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 'Female',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Experience',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 '8 years',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Location',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.location_on,
//                           color: Colors.grey,
//                           size: 16,
//                         ),
//                         SizedBox(width: 4),
//                         Text(
//                           'San Francisco, CA (5 miles away)',
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Qualifications',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         _buildQualificationChip('Certified Nursing Assistant'),
//                         _buildQualificationChip('First Aid'),
//                         _buildQualificationChip('Dementia Care'),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Availability Status',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.green.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 Icons.circle,
//                                 color: Colors.green,
//                                 size: 10,
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 'Available',
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // Availability Section
//               // Container(
//               //   width: double.infinity,
//               //   padding: const EdgeInsets.all(16),
//               //   decoration: BoxDecoration(
//               //     color: Colors.white,
//               //     borderRadius: BorderRadius.circular(10),
//               //     boxShadow: [
//               //       BoxShadow(
//               //         color: Colors.grey.withOpacity(0.1),
//               //         spreadRadius: 1,
//               //         blurRadius: 5,
//               //       ),
//               //     ],
//               //   ),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       const Text(
//               //         'Availability',
//               //         style: TextStyle(
//               //           fontSize: 18,
//               //           fontWeight: FontWeight.bold,
//               //         ),
//               //       ),
//               //       const SizedBox(height: 16),
//               //       // Day selection
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //         children: [
//               //           _buildDayButton('Mon', false),
//               //           _buildDayButton('Tue', true),
//               //           _buildDayButton('Wed', true),
//               //           _buildDayButton('Thu', false),
//               //           _buildDayButton('Fri', false),
//               //         ],
//               //       ),
//               //       const SizedBox(height: 8),
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //         children: [
//               //           _buildDayButton('Sat', false),
//               //           _buildDayButton('Sun', false),
//               //           const SizedBox(width: 40),
//               //           const SizedBox(width: 40),
//               //           const SizedBox(width: 40),
//               //         ],
//               //       ),
//               //       const SizedBox(height: 24),
//               //       // Time slots
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           _buildTimeButton('9:00 AM'),
//               //           _buildTimeButton('11:00 AM'),
//               //         ],
//               //       ),
//               //       const SizedBox(height: 16),
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           _buildTimeButton('2:00 PM'),
//               //           _buildTimeButton('4:00 PM'),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // const SizedBox(height: 24),
//               // // Reviews
//               // Container(
//               //   width: double.infinity,
//               //   padding: const EdgeInsets.all(16),
//               //   decoration: BoxDecoration(
//               //     color: Colors.white,
//               //     borderRadius: BorderRadius.circular(10),
//               //     boxShadow: [
//               //       BoxShadow(
//               //         color: Colors.grey.withOpacity(0.1),
//               //         spreadRadius: 1,
//               //         blurRadius: 5,
//               //       ),
//               //     ],
//               //   ),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           const Text(
//               //             'Reviews',
//               //             style: TextStyle(
//               //               fontSize: 18,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //           TextButton(
//               //             onPressed: () {
//               //               // Handle view all reviews
//               //             },
//               //             child: Row(
//               //               children: const [
//               //                 Text(
//               //                   'View all',
//               //                   style: TextStyle(
//               //                     color: Colors.blue,
//               //                   ),
//               //                 ),
//               //                 Icon(
//               //                   Icons.chevron_right,
//               //                   color: Colors.blue,
//               //                   size: 16,
//               //                 ),
//               //               ],
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //       const SizedBox(height: 16),
//               //       // Review 1
//               //       _buildReviewItem(
//               //         'Sarah Miller',
//               //         5,
//               //         'Emily took wonderful care of my mother. She was patient, kind, and professional. Would highly recommend!',
//               //         '2 weeks ago',
//               //       ),
//               //       const Divider(),
//               //       // Review 2
//               //       _buildReviewItem(
//               //         'Robert Chen',
//               //         4,
//               //         'Very reliable and my dad enjoys her company. She\'s always on time and communicates well.',
//               //         '1 month ago',
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),

//     );
//   }

//   Widget _buildQualificationChip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Color(0xFF3B82F6).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           color: Color(0xFF3B82F6),
//           fontSize: 12,
//         ),
//       ),
//     );
//   }

//   Widget _buildDayButton(String day, bool isSelected) {
//     return Container(
//       width: 60,
//       height: 40,
//       decoration: BoxDecoration(
//         color: isSelected ? Color(0xFF3B82F6) : Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         border: isSelected ? null : Border.all(color: Color(0xFF3B82F6)),
//       ),
//       child: Center(
//         child: Text(
//           day,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.blue,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeButton(String time) {
//     return Container(
//       width: 150,
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         border: Border.all(color: Color(0xFF3B82F6)),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text(
//         time,
//         style: const TextStyle(
//           color: Color(0xFF3B82F6),
//           fontWeight: FontWeight.bold,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget _buildReviewItem(String name, int rating, String comment, String time) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Row(
//               children: List.generate(5, (index) {
//                 return Icon(
//                   index < rating ? Icons.star : Icons.star_border,
//                   color: Colors.amber,
//                   size: 16,
//                 );
//               }),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           comment,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[700],
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           time,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[500],
//           ),
//         ),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }

// import 'package:carely/models/booking_model.dart';
// import 'package:carely/providers/booking_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BookingsScreenCg extends StatefulWidget {
//   const BookingsScreenCg({super.key});

//   @override
//   State<BookingsScreenCg> createState() => _BookingsScreenCgState();
// }

// class _BookingsScreenCgState extends State<BookingsScreenCg> {
//   int _selectedTabIndex = 0;
//   final List<String> _tabs = ['Upcoming', 'Pending', 'Completed'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Bookings'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Tab bar
//           Container(
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: List.generate(
//                 _tabs.length,
//                 (index) => Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedTabIndex = index;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: _selectedTabIndex == index
//                             ? Colors.white
//                             : Colors.transparent,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: _selectedTabIndex == index
//                             ? [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   spreadRadius: 1,
//                                   blurRadius: 3,
//                                   offset: const Offset(0, 1),
//                                 ),
//                               ]
//                             : null,
//                       ),
//                       child: Text(
//                         _tabs[index],
//                         style: TextStyle(
//                           color: _selectedTabIndex == index
//                               ? Colors.black
//                               : Colors.grey,
//                           fontWeight: _selectedTabIndex == index
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Content based on selected tab
//           Expanded(
//             child: _buildTabContent(),
//           ),
//         ],
//       ),

//     );
//   }

//   Widget _buildTabContent() {
//     if (_selectedTabIndex == 0) {
//       // Upcoming tab (Image 3)
//       return _buildUpcomingTab();
//     } else if (_selectedTabIndex == 1) {
//       // Pending tab
//       return _buildPendingTab();
//     } else {
//       // Completed tab (Images 1-2)
//       return _buildCompletedTab();
//     }
//   }

//   Widget _buildUpcomingTab() {
//   final caregiverId = FirebaseAuth.instance.currentUser.uid
//   final provider = Provider.of<BookingProvider>(context);

//   return StreamBuilder<List<Booking>>(
//     stream: provider.getBookingsByStatus(caregiverId, 'confirmed'),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return const Center(child: Text('No upcoming bookings'));
//       }

//       final bookings = snapshot.data!;

//       return ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final booking = bookings[index];

//           return FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance
//                 .collection('seekers')
//                 .doc(booking.seekerId)
//                 .get(),
//             builder: (context, seekerSnapshot) {
//               if (seekerSnapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
//               }

//               final seekerData = seekerSnapshot.data?.data() as Map<String, dynamic>?;

//               final seekerName = seekerData?['fullName'] ?? 'Unknown';
//               final seekerImage = seekerData?['profileImageUrl'] ?? 'assets/default_user.png';
//               final address = seekerData?['location'] ?? 'No address';

//               return _buildBookingCard(
//                 name: seekerName,
//                 imageUrl: seekerImage,
//                 careType: booking.serviceType,
//                 date: booking.date,
//                 time: booking.time,
//                 address: address,
//                 statusLabel: 'Confirmed',
//                 statusColor: Colors.green,
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }

// Widget _buildBookingCard({
//   required String name,
//   required String imageUrl,
//   required String careType,
//   required DateTime date,
//   required String time,
//   required String address,
//   required String statusLabel,
//   required Color statusColor,
// }) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.1),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: imageUrl.startsWith('http')
//                     ? NetworkImage(imageUrl)
//                     : AssetImage(imageUrl) as ImageProvider,
//                 radius: 20,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     Text(careType, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: statusColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   statusLabel,
//                   style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Divider(height: 1),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const Icon(Icons.event, size: 16, color: Colors.red),
//                   const SizedBox(width: 8),
//                   Text('${date.toLocal().toString().split(' ')[0]}, $time',
//                       style: TextStyle(color: Colors.grey[700])),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       address,
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(12),
//               bottomRight: Radius.circular(12),
//             ),
//           ),
//           child: TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//               foregroundColor: Colors.white,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(12),
//                 ),
//               ),
//             ),
//             child: const Text('View Details'),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _buildPendingTab() {
//     // Sample data for pending requests
//     final pendingRequests = [
//       Booking(

//       ),
//     ];

//     return pendingRequests.isEmpty
//         ? const Center(child: Text('No pending requests'))
//         : ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: pendingRequests.length,
//             itemBuilder: (context, index) {
//               final request = pendingRequests[index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage(request.clientImageUrl ?? 'assets/default_user.png'),
//                           radius: 20,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 request.clientName,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               Text(
//                                 request.careType,
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Text(
//                             'New',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(Icons.event, size: 16, color: Colors.red),
//                         const SizedBox(width: 8),
//                         Text(
//                           '${request.date}, ${request.timeStart} - ${request.timeEnd}',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             request.clientAddress,
//                             style: TextStyle(color: Colors.grey[700]),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (request.notes != null) ...[
//                       const SizedBox(height: 12),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[50],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           '"${request.notes}"',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                       ),
//                     ],
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () {},
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.red,
//                               side: const BorderSide(color: Colors.red),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text('Decline'),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text('Accept'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//   }

//   Widget _buildCompletedTab() {
//     // Sample data for completed bookings (based on Images 1-2)
//     final completedBookings = [
//       Booking(

//     ];

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: completedBookings.length,
//       itemBuilder: (context, index) {
//         final booking = completedBookings[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage(booking.clientImageUrl ?? 'assets/default_user.png'),
//                     radius: 20,
//                     child: booking.clientImageUrl == null
//                         ? const Icon(Icons.person, color: Colors.white)
//                         : null,
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               booking.clientName,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 'completed',
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(
//                               'DateTime.parse(booking.date)',
//                               style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(Icons.access_time, size: 14, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${booking.timeStart} - ${booking.timeEnd}',
//                               style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(
//                               booking.clientAddress,
//                               style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
