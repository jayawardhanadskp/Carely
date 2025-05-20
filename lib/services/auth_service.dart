import 'package:carely/models/caregiver_model.dart';
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
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: $e');
      throw e; 
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }

  Future<String?> uploadProfileImage(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      final ref = _storage
          .ref('caregiver_profiles/${DateTime.now().millisecondsSinceEpoch}.png');
      await ref.putFile(imageFile).whenComplete(() => null);
      final String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw e;
    }
  }

  Future<void> saveCaregiverProfile(CaregiverProfile profile) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('caregivers').doc(user.uid).set(
              profile.toFirestore(),
            );
      } else {
        throw Exception('User not authenticated.');
      }
    } catch (e) {
      print('Error saving caregiver profile to Firestore: $e');
      throw e; 
    }
  }

  Future<CaregiverProfile?> getCaregiverProfile(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('caregivers').doc(uid).get();
      if (snapshot.exists && snapshot.data() != null) {
        return CaregiverProfile.fromFirestore(snapshot.data()!, snapshot.id);
      }
      return null;
    } catch (e) {
      print('Error fetching caregiver profile: $e');
      throw e;
    }
  }
}