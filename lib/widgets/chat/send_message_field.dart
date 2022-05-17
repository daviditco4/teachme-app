import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/pages/messages/chat_page.dart';

import '../../helpers/message_keys.dart';

class SendMessageField extends StatefulWidget {
  @override
  _SendMessageFieldState createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  final _textController = TextEditingController();
  var _sendEnabled = false;

  void _send() async {
    try {
      setState(() => _sendEnabled = false);
      final user = FirebaseAuth.instance.currentUser!;

      FirebaseFirestore.instance.collection(messagesCollectionPath).add({
        MessageKeys.txt: _textController.text.trim(),
        MessageKeys.crAt: Timestamp.now(),
        MessageKeys.cr: {
          MessageKeys.uid: user.uid,
          MessageKeys.usn: user.displayName,
          MessageKeys.pto: user.photoURL,
        },
      });
      _textController.clear();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const height = 56.0;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Theme(
              data: theme.copyWith(
                colorScheme: colorScheme.copyWith(primary: theme.hintColor),
              ),
              child: TextField(
                controller: _textController,
                onChanged: (value) {
                  setState(() => _sendEnabled = value.trim().isNotEmpty);
                },
                minLines: 1,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(height / 2)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: height,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _sendEnabled ? colorScheme.secondary : theme.disabledColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.send),
              splashRadius: height / 2,
              color: colorScheme.onSecondary,
              disabledColor: theme.hintColor,
              onPressed: _sendEnabled ? _send : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
