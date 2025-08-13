// ignore_for_file: use_rethrow_when_possible

import 'package:carely/models/caregiver_model.dart';
import 'package:carely/models/seeker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<String?> uploadProfileImage(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      final ref = _storage.ref(
        'caregiver_profiles/${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await ref.putFile(imageFile).whenComplete(() => null);
      final String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveCaregiverProfile(CaregiverProfile profile) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final String uid = user.uid;
        final docRef = _firestore.collection('caregivers').doc(uid);

        // First, set the document (excluding id to avoid null in Firestore)
        await docRef.set(profile.toMap());

        // Then, update the document to include the ID (UID in this case)
        await docRef.update({'id': uid});
      } else {
        throw Exception('User not authenticated.');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Seeker Firebase Authentication

  Future<UserCredential> createSeekerUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> uploadSeekerProfileImage(File imageFile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in.");

    final ref = _storage.ref().child(
      'seekers_profiles/${user.uid}/profile.jpg',
    );
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> saveSeekerProfile(SeekerProfile profile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in.");

    final docRef = _firestore.collection('seekers').doc(user.uid);
    await docRef.set(profile.toMap());
    await docRef.update({'uid': docRef.id});
  }


  /// check seeker or giver and get details form id
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      final seekerDoc = await _firestore.collection('seekers').doc(userId).get();
      if (seekerDoc.exists) {
        return seekerDoc.data();
      }

      final caregiverDoc =
          await _firestore.collection('caregivers').doc(userId).get();
      if (caregiverDoc.exists) {
        return caregiverDoc.data();
      }

      return null; 
    } catch (e) {
      throw e;
    }
  }
}
