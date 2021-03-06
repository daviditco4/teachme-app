import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../helpers/chat_keys.dart';
import 'chat_list_item.dart';

const chatsCollectionPath = "chats";

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    Key? key,
    required this.chatsListCollectionPath,
  }) : super(key: key);

  final String chatsListCollectionPath;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final chtCollec = firestore.collection(chatsListCollectionPath);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chtCollec.orderBy(ChatKeys.upAt, descending: true).snapshots(),
      builder: (_, snapshot) {
        final isWaiting = snapshot.connectionState == ConnectionState.waiting;
        if (isWaiting) return const Center(child: CircularProgressIndicator());

        final docs = snapshot.data?.docs;

        if (docs == null) {
          return const Center(
            child: Text("No has comenzado a chatear todavía."),
          );
        }

        final n = docs.length;

        return ListView.builder(
          itemCount: n,
          itemBuilder: (_, i) {
            final document = docs[i];
            final documentData = document.data();
            final messagesCollectionPath =
                "$chatsCollectionPath/${documentData[ChatKeys.msg]}/messages";
            const rpKey = ChatKeys.rp;
            final recipient = documentData[rpKey];
            final usn = recipient[ChatKeys.usn];
            final rpPhoto = recipient[ChatKeys.pto];

            return ChatListItem(
              key: ValueKey(document.id),
              messagesCollectionPath: messagesCollectionPath,
              recipientUid: document.id,
              recipientUsername: usn,
              recipientPhotoURL: rpPhoto,
            );
          },
        );
      },
    );
  }
}
