import 'dart:convert';

import 'package:carely/models/review_model.dart';

class CaregiverProfile {
  final String? id;
  final String role;
  final String fullName;
  final String email;
  final String phone;
  final String? gender;
  final String yearsOfExperience;
  final String qualifications;
  final String location;
  final String bio;
  final String? profileImageUrl;
  final DateTime? registrationTimestamp;
  final List<String> bookings;
  final List<Review>? reviews;

  CaregiverProfile({
    this.id,
    required this.role,
    required this.fullName,
    required this.email,
    required this.phone,
    this.gender,
    required this.yearsOfExperience,
    required this.qualifications,
    required this.location,
    required this.bio,
    this.profileImageUrl,
    this.registrationTimestamp,
    this.bookings = const [], 
    this.reviews = const [], 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'yearsOfExperience': yearsOfExperience,
      'qualifications': qualifications,
      'location': location,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'registrationTimestamp': registrationTimestamp?.millisecondsSinceEpoch,
      'bookings': bookings,
      'reviews': reviews,
    };
  }

  factory CaregiverProfile.fromMap(Map<String, dynamic> map) {
    return CaregiverProfile(
      id: map['id'],
      role: map['role'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      yearsOfExperience: map['yearsOfExperience'],
      qualifications: map['qualifications'],
      location: map['location'],
      bio: map['bio'],
      profileImageUrl: map['profileImageUrl'],
      registrationTimestamp: map['registrationTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['registrationTimestamp'])
          : null,
      bookings: List<String>.from(map['bookings'] ?? []),
      reviews: List<Review>.from(map['reviews'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());
  factory CaregiverProfile.fromJson(String source) =>
      CaregiverProfile.fromMap(json.decode(source));
}
