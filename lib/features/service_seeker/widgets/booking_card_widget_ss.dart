// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

enum BookingStatus { confirmed, pending, cancelled }

class BookingCardSs extends StatelessWidget {
  final String caregiverId;
  final String caregiverName;
  final double caregiverRating;
  final String date;
  final String time;
  final String location;
  final BookingStatus status;
  final String? imageUrl;

  const BookingCardSs({
    super.key,
    required this.caregiverId,
    required this.caregiverName,
    required this.caregiverRating,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCaregiverAvatar(imageUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caregiverName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today, date),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.access_time, time),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.location_on, location),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                context,
                '/seeker/chat',
                arguments: caregiverId,
              );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaregiverAvatar(String? imageUrl) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          backgroundImage:
              imageUrl != null
                  ? NetworkImage(imageUrl)
                  : AssetImage('assets/user_avatar.png') as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  caregiverRating.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Icon(Icons.star, color: Colors.white, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color backgroundColor;
    String statusText;

    switch (status) {
      case BookingStatus.confirmed:
        backgroundColor = Colors.green.withOpacity(0.1);
        statusText = 'confirmed';
        break;
      case BookingStatus.pending:
        backgroundColor = Colors.amber.withOpacity(0.1);
        statusText = 'pending';
        break;
      case BookingStatus.cancelled:
        backgroundColor = Colors.red.withOpacity(0.1);
        statusText = 'cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color:
              status == BookingStatus.confirmed
                  ? Colors.green
                  : status == BookingStatus.pending
                  ? Colors.amber[800]
                  : Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
}
