// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/MyClass_page.dart';
import 'package:teachme_app/pages/lesson_search/teacher_profile_page.dart';
import 'package:teachme_app/pages/profile_page.dart';
import 'package:teachme_app/widgets/other/tm_navigator.dart';

int _currentIndex = 0;

class TMBottomNavigationBar extends StatefulWidget {
  const TMBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _TMBottomNavigationBarState createState() => _TMBottomNavigationBarState();
}

class _TMBottomNavigationBarState extends State<TMBottomNavigationBar> {
  late List<Widget> _pages;

  //void _selectTab(int index) => setState(() => _currentIndex = index);

  @override
  void initState() {
    super.initState();
    _pages = [
      MyClass(),
      ProfilePage() /*TODO: CAMBIAR A SEARCH}*/,
      TeacherProfilePage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    //child: _pages[_currentIndex],
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        onTap: (index) => setState(() {
              _currentIndex = index;
              TMNavigator.navigateTo(this.context, _pages[_currentIndex]);
            }));
    //);
  }
}
