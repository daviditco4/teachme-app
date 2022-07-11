import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

import '../../widgets/chat/messages_list_view.dart';
import '../../widgets/chat/send_message_field.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messagesCollectionPath =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.bottomNavBarBackground,
        title: const Text('Chat'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MessagesListView(
              messagesCollectionPath: messagesCollectionPath,
            ),
          ),
          const SizedBox(height: 8.0),
          SendMessageField(messagesCollectionPath: messagesCollectionPath),
        ],
      ),
    );
  }
}
