import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carely/models/message_model.dart';
import 'package:carely/services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final ChatService _chatService = ChatService();

  List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Stream<List<Message>>? _messageStream;
  Stream<List<Message>>? get messageStream => _messageStream;

  /// Load real-time message stream
  void loadMessages(String chatId) {
    _isLoading = true;
    notifyListeners();

    _messageStream = _chatService.getMessages(chatId);
    _isLoading = false;
    notifyListeners();
  }

  /// Send a message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    await _chatService.sendMessage(chatId, senderId, text);
  }

  /// Create or get a chat ID
  Future<String> createOrGetChatId(String user1Id, String user2Id) async {
    return await _chatService.createOrGetChatId(user1Id, user2Id);
  }



  Stream<List<Map<String, dynamic>>> getUserChats(String userId) {
    return _db
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'chatId': doc.id,
          'lastMessage': data['lastMessage'] ?? '',
          'lastTimestamp': data['lastTimestamp'],
          'participants': List<String>.from(data['participants']),
        };
      }).toList();
    });
  }

}
