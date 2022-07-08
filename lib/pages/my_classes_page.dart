import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/viewClass/card_class.dart';
import '../widgets/other/tm_navigator.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  State<MyClass> createState() => _MyClass();
}

class _MyClass extends State<MyClass> {
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
        // extendBodyBehindAppBar: true,
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
                    TMNavigator.navigateToPage(context, const SettingsPage())),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => TMNavigator.navigateToPage(
                    context, const NotificationsPage()),
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: MyColors.black,
            indicatorWeight: 7,
            indicatorColor: MyColors.bottomNavBarBackground,
            tabs: [
              Tab(text: "Próximas clases"),
              Tab(text: "Calendario"),
            ],
          ),
          backgroundColor: MyColors.background,
          elevation: 0,
        ),
        bottomNavigationBar: const TMBottomNavigationBar(),
        body: TabBarView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      CardClass(
                          title:
                              'Matematica Discreta',
                          textButton: 'Detalles',
                          schedule: '08:00',
                          direction: 'Calle falsa 123'),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                      calendarController: _calendarController,
                      headerStyle: HeaderStyle(
                        decoration: const BoxDecoration(
                          color: MyColors.bottomNavBarBackground,
                        ),
                        headerMargin: const EdgeInsets.only(bottom: 8),
                        titleTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        formatButtonTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        leftChevronIcon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
          )
        )
    );
  }
}
