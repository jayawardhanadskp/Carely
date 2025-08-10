import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String messageType;

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.messageType,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      messageType: map['messageType'],
    );
  }
}
