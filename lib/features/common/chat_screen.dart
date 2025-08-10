import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carely/providers/chat_provider.dart';
import 'package:carely/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? _chatId;
  late String otherUserId;
  final TextEditingController _controller = TextEditingController();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Prevent re-running on rebuild
    if (!_isInitialized) {
      otherUserId = ModalRoute.of(context)!.settings.arguments as String;
      _initializeChat();
      _isInitialized = true;
    }
  }

  Future<void> _initializeChat() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    final chatId = await chatProvider.createOrGetChatId(
      currentUserId,
      otherUserId,
    );

    setState(() {
      _chatId = chatId;
    });

    chatProvider.loadMessages(chatId);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (_chatId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          // Chat message list
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                final messageStream = chatProvider.messageStream;
                if (messageStream == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return StreamBuilder<List<Message>>(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const SizedBox();
                    final messages = snapshot.data!;
                    if (messages.isEmpty) {
                      return const Center(child: Text('No messages yet.'));
                    }

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg =
                            messages[messages.length -
                                index -
                                1]; // reverse order
                        final isMe = msg.senderId == currentUserId;
                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      Provider.of<ChatProvider>(
                        context,
                        listen: false,
                      ).sendMessage(
                        chatId: _chatId!,
                        senderId: currentUserId,
                        text: text,
                      );
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
