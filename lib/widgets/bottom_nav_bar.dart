// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/MyClass_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/card_class.dart';

int _currentIndex = 0;
int previousIndex = _currentIndex;

PageRouteBuilder _noAnimationRouter(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation1, animation2) => page,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

class TMBottomNavigationBar extends StatefulWidget {
  const TMBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _TMBottomNavigationBarState createState() => _TMBottomNavigationBarState();
}

class _TMBottomNavigationBarState extends State<TMBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyColors.bottomNavBarBackground,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30.0,
        selectedItemColor: MyColors.bottomNavBarSelected,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: 'My Classes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile')
        ],
        onTap: (index) {
          setState(() {
            previousIndex = _currentIndex;
            _currentIndex = index;
          });
          if (previousIndex != _currentIndex) {
            switch (_currentIndex) {
              case 0:
                Navigator.pushReplacement(
                    context, _noAnimationRouter(MyClass()));
                break;
              case 1:
                /*TODO: Navigation a Search */
                break;
              case 2:
                /* TODO: Navigation a Chats */
                break;
              case 3:
                Navigator.pushReplacement(
                    context, _noAnimationRouter(SettingsPage()));
                break;
            }
          }
        });
  }
}
