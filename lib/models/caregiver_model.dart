import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverProfile {
  final String? uid;
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

  CaregiverProfile({
    this.uid,
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
  });

  // Factory method to create a CaregiverProfile from a Firestore document
  factory CaregiverProfile.fromFirestore(Map<String, dynamic> data, String? uid) {
    return CaregiverProfile(
      uid: uid,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      gender: data['gender'],
      yearsOfExperience: data['yearsOfExperience'] ?? '',
      qualifications: data['qualifications'] ?? '',
      location: data['location'] ?? '',
      bio: data['bio'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      registrationTimestamp: data['registrationTimestamp']?.toDate(),
    );
  }

  // Method to convert the CaregiverProfile to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'yearsOfExperience': yearsOfExperience,
      'qualifications': qualifications,
      'location': location,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'registrationTimestamp': registrationTimestamp ?? FieldValue.serverTimestamp(),
    };
  }
}