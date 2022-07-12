import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/chat/chats_list_view.dart';

const chatsMapCollectionPath = "chatsMappedByUsers";
const chatsListCollectionPath = "chatsList";

class ChatsOverviewPage extends StatelessWidget {
  const ChatsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final chatsList =
        "$chatsMapCollectionPath/${auth.currentUser!.uid}/$chatsListCollectionPath";

    return Scaffold(
      body: ChatsListView(chatsListCollectionPath: chatsList),
      bottomNavigationBar: const TMBottomNavigationBar(),
    );
  }
}
