import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/card_class.dart';
import '../widgets/other/tm_navigator.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  State<MyClass> createState() => _MyClass();
}

class _MyClass extends State<MyClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.background,
        appBar: AppBar(
          leading: const ImageIcon(
            AssetImage("assets/images/teach_me_logo.png"),
            color: MyColors.black,
          ),
          centerTitle: true,
          title: const Text('Mis Clases',
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
        bottomNavigationBar: const TMBottomNavigationBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(top: 5, bottom: 40),
                  //   child: Text("Mis Clases",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           fontSize: 30, fontWeight: FontWeight.bold)),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 40),
                    child:
                        Text("Proximas clases", style: TextStyle(fontSize: 20)),
                  ),
                  CardClass(
                      title:
                          'Aun no tienes clases agendadas, busca tu proxima clase',
                      textButton: 'Proxima clase',
                      schedule: '',
                      direction: ''),
                ],
              ),
            ),
          ),
        ));
  }
}
