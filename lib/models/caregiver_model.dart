// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class CaregiverProfile {
  final String? uid;
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

  CaregiverProfile({
    this.uid,
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
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
    };
  }

  factory CaregiverProfile.fromMap(Map<String, dynamic> map) {
    return CaregiverProfile(
      uid: map['uid'] != null ? map['uid'] as String : null,
      role: map['role'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      yearsOfExperience: map['yearsOfExperience'] as String,
      qualifications: map['qualifications'] as String,
      location: map['location'] as String,
      bio: map['bio'] as String,
      profileImageUrl: map['profileImageUrl'] != null ? map['profileImageUrl'] as String : null,
      registrationTimestamp: map['registrationTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['registrationTimestamp'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaregiverProfile.fromJson(String source, String id) => CaregiverProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
