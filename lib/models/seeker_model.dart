import 'dart:convert';

class SeekerProfile {
  final String? uid;
  final String role;
  final String fullName;
  final String email;
  final String phone;
  final String? gender;
  final String location;
  final String? profileImageUrl;
  final DateTime? registrationTimestamp;

  SeekerProfile({
    this.uid,
    required this.role,
    required this.fullName,
    required this.email,
    required this.phone,
    this.gender,
    required this.location,
    this.profileImageUrl,
    this.registrationTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'registrationTimestamp': registrationTimestamp?.millisecondsSinceEpoch,
    };
  }

  factory SeekerProfile.fromMap(Map<String, dynamic> map) {
    return SeekerProfile(
      uid: map['uid'],
      role: map['role'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      location: map['location'],
      profileImageUrl: map['profileImageUrl'],
      registrationTimestamp: map['registrationTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['registrationTimestamp'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory SeekerProfile.fromJson(String source) =>
      SeekerProfile.fromMap(json.decode(source));
}
