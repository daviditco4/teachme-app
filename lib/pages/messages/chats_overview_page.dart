import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/chat/chats_list_view.dart';
import '../../widgets/other/tm_navigator.dart';
import '../notifications_page.dart';
import '../settings_page.dart';

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
      appBar: AppBar(
          backgroundColor: MyColors.background,
          leading: const ImageIcon(
            AssetImage("assets/images/teach_me_logo.png"),
            color: MyColors.black,
          ),
          centerTitle: true,
          title: const Text('Mensajes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_none,
                    color: Colors.black),
                onPressed: () => TMNavigator.navigateToPage(
                    context, const NotificationsPage()),
              ),
            ),
          ]
      ),
      body: ChatsListView(chatsListCollectionPath: chatsList),
      bottomNavigationBar: const TMBottomNavigationBar(),
    );
  }
}
