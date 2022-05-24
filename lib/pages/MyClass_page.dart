import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/card_class.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyClass(),
    );
  }
}

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
        bottomNavigationBar: TMBottomNavigationBar(),
        appBar: AppBar(
          backgroundColor: MyColors.background,
          elevation: 0,
          leading: const ImageIcon(
          AssetImage("assets/images/teach_me_logo.png"),
            color: MyColors.buttonCardClass,
          ),
          centerTitle: true,
          title: const Text('Mis Clases',
          style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          )),
          actions: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () => navigateTo(context, const NotificationsPage()),
          ),
          ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 40),
                    child: Text("Proximas clases",
                        style: TextStyle(
                            fontSize: 20)),
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
