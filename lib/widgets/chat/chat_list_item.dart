import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.messagesCollectionPath,
    required this.recipientUsername,
    required this.recipientPhotoURL,
  }) : super(key: key);

  final String messagesCollectionPath, recipientUsername, recipientPhotoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/chat',
            arguments: messagesCollectionPath,
          );
        },
        leading: CircleAvatar(
          foregroundImage: NetworkImage(recipientPhotoURL),
          child: Text(recipientUsername.substring(0, 1)),
        ),
        title: Text(
          recipientUsername,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
