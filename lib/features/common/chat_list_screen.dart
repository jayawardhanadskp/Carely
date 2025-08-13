import 'package:carely/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import '../../../providers/chat_provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatProvider.getUserChats(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data ?? [];

          if (chats.isEmpty) {
            return const Center(child: Text('No chats yet.'));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              final List<String> participants =
                  List<String>.from(chat['participants']);
              final otherUserId =
                  participants.firstWhere((id) => id != userId);

              final lastMessage = chat['lastMessage'];
              final lastTimestamp = chat['lastTimestamp'] as Timestamp?;
              final formattedTime = lastTimestamp != null
                  ? DateFormat('MMM d, h:mm a').format(lastTimestamp.toDate())
                  : '';

              return FutureBuilder(
                future: AuthService().getUserDetails(otherUserId),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }
                  if (asyncSnapshot.hasError) {
                    return ListTile(
                      title: Text('Error loading user'),
                      subtitle: Text(asyncSnapshot.error.toString()),
                    );
                  }
                  final userDetails = asyncSnapshot.data;
                  return ListTile(
                    title: Text('${userDetails?['fullName'] ?? 'Unknown User'}'), 
                    subtitle: Text(lastMessage),
                    trailing: Text(formattedTime),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/seeker/chat',
                        arguments: otherUserId,
                      );
                    },
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}
