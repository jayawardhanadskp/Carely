// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CaregiverCardSs extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String specialty;
  final double rating;
  final VoidCallback onViewProfile;

  const CaregiverCardSs({
    super.key,
    required this.name,
    this.imageUrl,
    required this.specialty,
    required this.rating,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
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
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        imageUrl != null
                            ? NetworkImage(imageUrl!)
                            : AssetImage('assets/user_avatar.png')
                                as ImageProvider,
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
                            rating.toString(),
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
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      specialty,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onViewProfile,
                child: Text(
                  'View Profile',
                  style: TextStyle(color: Color(0xFF2563EB), fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
