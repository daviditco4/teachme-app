// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/my_classes_page.dart';
import 'package:teachme_app/pages/messages/chat_room.dart';
import 'package:teachme_app/pages/student_profile_page.dart';
import 'package:teachme_app/pages/teacher_profile_page.dart';
import 'package:teachme_app/widgets/other/tm_navigator.dart';

import '../pages/search_page.dart';

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
      SearchPage() /*TODO: CAMBIAR A SEARCH */,
      ChatRoom(),
      TeacherProfilePage()
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
              icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        onTap: (index) => setState(() {
              _currentIndex = index;
              TMNavigator.navigateToPage(this.context, _pages[_currentIndex]);
            }));
    //);
  }
}
