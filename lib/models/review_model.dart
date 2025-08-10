import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  final String clientName;
  final String careGiverId;
  final String reviewText;
  final double rating;
  final DateTime timeAgo;

  Review({
    required this.clientName,
    required this.careGiverId,
    required this.reviewText,
    required this.rating,
    required this.timeAgo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientName': clientName,
      'careGiverId': careGiverId,
      'reviewText': reviewText,
      'rating': rating,
      'timeAgo': timeAgo.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      clientName: map['clientName'] as String,
      careGiverId: map['careGiverId'] as String,
      reviewText: map['reviewText'] as String,
      rating: map['rating'] as double,
      timeAgo: DateTime.fromMillisecondsSinceEpoch(map['timeAgo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
