import 'package:flutter/material.dart';

import '../../main.dart' show chatTopic;
import '../../widgets/chat/messages_list_view.dart';
import '../../widgets/chat/send_message_field.dart';

const messagesCollectionPath = '${chatTopic}Messages';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: MessagesListView()),
          const SizedBox(height: 8.0),
          SendMessageField(),
        ],
      ),
    );
  }
}
