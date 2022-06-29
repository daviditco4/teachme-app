// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/main.dart';
import 'package:teachme_app/pages/my_classes_page.dart';
import 'package:teachme_app/pages/messages/chat_room.dart';
import 'package:teachme_app/pages/profile/student_profile_page.dart';
import 'package:teachme_app/pages/profile/teacher_profile_page.dart';
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



  @override
  void initState() {
    super.initState();
    _pages = [
      MyClass(),
      //SearchPage() /*TODO: CAMBIAR A SEARCH */,
      //ChatRoom(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    //child: _pages[_currentIndex],
    return ValueListenableBuilder(
      valueListenable: userProfileType,
      builder: (context, value, widget) {
        var _items = [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: 'My Classes')
        ];

        if (value == ProfileType.student) {
          _items.add(
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search')
          );
          _pages.add(
            SearchPage()
          );
        }

        _items.addAll([
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ]);

        _pages.add(ChatRoom());
        _pages.add(value == ProfileType.teacher ? TeacherProfilePage() : StudentProfilePage());
        return BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: MyColors.bottomNavBarBackground,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            iconSize: 30.0,
            selectedItemColor: MyColors.bottomNavBarSelected,
            items: _items,
            onTap: (index) => setState(() {
              _currentIndex = index;
              TMNavigator.navigateToPage(this.context, _pages[_currentIndex]);
            }));
        //);
      },
    );
  }
}

/*

BottomNavigationBar(
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
              TMNavigator.navigateToPage(this.context, _pages[_currentIndex]);
            }));
    //);

 */