import 'package:carely/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ReviewProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Review> _review = [];
  bool _isLoading = false;
  String _error = '';

  List<Review> get review => _review;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> saveReview(Review reviewModel) async {
    _isLoading = true;
    notifyListeners();
    try {
      final docRef = _firestore
          .collection('caregivers')
          .doc(reviewModel.careGiverId)
          .collection('reviews')
          .doc();
      await docRef.set(reviewModel.toMap());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Review>> getAllReviews(String careGiverId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore
          .collection('caregivers')
          .doc(careGiverId)
          .collection('reviews')
          .get();

      _review = snapshot.docs
          .map((doc) => Review.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _isLoading = false;
      notifyListeners();
      return _review;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }
}

// _isLoading = true;
//     try {
//       final querySnapshot = await _firestore
//           .collection('caregivers')
//           .doc(careGiverId)
//           .collection('reviews')
//           .get();

//       final reviews = querySnapshot.docs
//           .map((doc) => Review.fromMap(doc.data()))
//           .toList();
//       _review = reviews;
//       print('Reviews============== $reviews');
//       _isLoading = false;
//       notifyListeners();
//       return reviews;
//     } catch (e) {
//       _error = e.toString();
//       _isLoading = false;
//       notifyListeners();
//       return [];
//     }
//   }
