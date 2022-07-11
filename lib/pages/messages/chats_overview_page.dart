import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/chat/chats_list_view.dart';
import '../../widgets/other/top_bar.dart';

const _chatsMapCollectionPath = "chatsMappedByUsers";

class ChatsOverviewPage extends StatelessWidget {
  const ChatsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final chatsList =
        "$_chatsMapCollectionPath/${auth.currentUser!.uid}/chatsList";

    return Scaffold(
      appBar: TopBar(title: "Mensajes"),
      body: ChatsListView(chatsListCollectionPath: chatsList),
      bottomNavigationBar: const TMBottomNavigationBar(),
    );
  }
}
