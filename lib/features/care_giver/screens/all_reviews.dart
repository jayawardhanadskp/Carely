import 'package:carely/models/review_model.dart';
import 'package:carely/providers/review_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllReviews extends StatefulWidget {
  const AllReviews({super.key});

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ReviewProvider>(
    //   context,
    //   listen: false,
    // ).getAllReviews(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Reviews')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<ReviewProvider>(
          builder: (context, reviewProvider, child) {
            final reviews = reviewProvider.review;
            if (reviewProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (reviewProvider.error.isNotEmpty) {
              return Center(
                child: Text(
                  reviewProvider.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            if (reviews.isEmpty) {
              return const Center(child: Text('No reviews available.'));
            }
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(context, review);
              },
            );
          },
        ),
      ),
    );
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
            DateFormat('dd MMM yyyy').format(review.timeAgo),
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
