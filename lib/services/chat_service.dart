/* chats (collection)
  └─ chatId (doc, e.g. user1Id_user2Id or auto-generated)
     ├─ participants: [user1Id, user2Id]
     ├─ lastMessage: "See you soon"
     ├─ lastTimestamp: 2025-08-10
     └─ messages (subcollection)
         └─ messageId (doc)
            ├─ senderId
            ├─ text
            ├─ timestamp
            └─ messageType: text/image */

import 'package:carely/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  /// create chat room
  Future<String> createOrGetChatId(String user1Id, String user2Id) async {
    final query = await FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: user1Id)
        .get();

    for (var doc in query.docs) {
      List participants = doc['participants'];
      if (participants.contains(user2Id)) {
        return doc.id;
      }
    }

    // No chat exists — create one
    final newDoc = FirebaseFirestore.instance.collection('chats').doc();
    await newDoc.set({
      'participants': [user1Id, user2Id],
      'lastMessage': '',
      'lastTimestamp': FieldValue.serverTimestamp(),
    });

    return newDoc.id;
  }

  /// send meddage
  Future<void> sendMessage(
    String chatId,
    String senderId,
    String message,
  ) async {
    final messageDoc = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageDoc.set({
      'senderId': senderId,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
      'messageType': 'text',
    });

    // Update last message in chat document
    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastMessage': message,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }

  ///read
  Stream<List<Message>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList(),
        );
  }
}
