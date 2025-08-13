// ignore_for_file: deprecated_member_use

import 'package:carely/models/caregiver_model.dart';
import 'package:carely/models/review_model.dart';
import 'package:carely/providers/review_provider.dart';
import 'package:carely/providers/seeker_profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CaregiverProfileViewSs extends StatefulWidget {
  const CaregiverProfileViewSs({super.key});

  @override
  State<CaregiverProfileViewSs> createState() => _CaregiverProfileViewSsState();
}

class _CaregiverProfileViewSsState extends State<CaregiverProfileViewSs> {
  final TextEditingController _reviewController = TextEditingController();
  double _reating = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SeekerProfileProvider>(
        context,
        listen: false,
      ).fetchSeekerProfile();

      Provider.of<ReviewProvider>(context, listen: false).getAllReviews(
        (ModalRoute.of(context)!.settings.arguments as CaregiverProfile).id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final CaregiverProfile caregiver =
        ModalRoute.of(context)!.settings.arguments as CaregiverProfile;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Caregiver Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_outlined, color: Colors.green,),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/seeker/chat',
                arguments: caregiver.id,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(caregiver.profileImageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                caregiver.fullName,
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
                caregiver.bio,
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
                                caregiver.gender ?? '',
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
                                caregiver.yearsOfExperience,
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
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(
                          caregiver.location,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Qualifications',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildQualificationChip(caregiver.qualifications),
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
                              Icon(Icons.circle, color: Colors.green, size: 10),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Availability',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Day selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDayButton('Mon', false),
                        _buildDayButton('Tue', true),
                        _buildDayButton('Wed', true),
                        _buildDayButton('Thu', false),
                        _buildDayButton('Fri', false),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDayButton('Sat', false),
                        _buildDayButton('Sun', false),
                        const SizedBox(width: 40),
                        const SizedBox(width: 40),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Time slots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeButton('9:00 AM'),
                        _buildTimeButton('11:00 AM'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeButton('2:00 PM'),
                        _buildTimeButton('4:00 PM'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _reating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your Thoughts',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 0.0),
                    Consumer<SeekerProfileProvider>(
                      builder: (context, provider, _) {
                        if (provider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final profile = provider.profile;

                        if (profile == null) {
                          return const Center(child: Text("Profile not found"));
                        }
                        return Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3B82F6),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                final reviewModel = Review(
                                  clientName: profile.fullName,
                                  careGiverId: caregiver.id!,
                                  reviewText: _reviewController.text,
                                  rating: _reating,
                                  timeAgo: DateTime.now(),
                                );
                                Provider.of<ReviewProvider>(
                                  context,
                                  listen: false,
                                ).saveReview(reviewModel);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Review Added'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                Provider.of<ReviewProvider>(
                                  context,
                                  listen: false,
                                ).getAllReviews(caregiver.id!);
                                _reating = 0.0;
                                _reviewController.clear();
                              },
                              child: const Text(
                                'Add Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Reviews
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle view all reviews
                          },
                          child: Row(
                            children: const [
                              Text(
                                'View all',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Consumer<ReviewProvider>(
                      builder: (context, reviewProvider, child) {
                        if (reviewProvider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (reviewProvider.error.isNotEmpty) {
                          return Center(
                            child: Text('Error: ${reviewProvider.error}'),
                          );
                        }

                        final reviews = reviewProvider.review;

                        if (reviews.isEmpty) {
                          return const Center(child: Text('No reviews yet.'));
                        }

                        return Column(
                          children: reviews.map((review) {
                            return _buildReviewItem(
                              review.clientName ?? 'Anonymous',
                              review.rating.toInt(),
                              review.reviewText,
                              DateFormat('dd MMM yyyy').format(review.timeAgo),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/seeker/bookingCaregiver',
              arguments: caregiver,
            );
          },
          child: const Text(
            'Book This Caregiver',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
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

  Widget _buildDayButton(String day, bool isSelected) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF3B82F6) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Color(0xFF3B82F6)),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3B82F6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        time,
        style: const TextStyle(
          color: Color(0xFF3B82F6),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildReviewItem(
    String name,
    int rating,
    String comment,
    String time,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(comment, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        const SizedBox(height: 4),
        Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        const SizedBox(height: 8),
      ],
    );
  }
}
