import 'package:flutter/material.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import '../../widgets/other/teacher_profile_overview.dart';
import '../../widgets/other/tm_navigator.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      bottomNavigationBar: const TMBottomNavigationBar(),
      appBar: AppBar(
          leading: const ImageIcon(
            AssetImage("assets/images/teach_me_logo.png"),
            color: MyColors.black,
          ),
          centerTitle: true,
          title: const Text('Chat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings, color: Colors.black),
                onPressed: () =>
                    TMNavigator.navigateTo(context, const SettingsPage())),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () =>
                    TMNavigator.navigateTo(context, const NotificationsPage()),
              ),
            ),
          ],
          backgroundColor: MyColors.background,
          elevation: 0,
        ),
      body: Card(
        margin: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: TeacherProfileOverview(),
        ),
      ),
    );
  }
}
