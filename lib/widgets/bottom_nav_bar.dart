// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

class TMBottomNavigationBar extends StatefulWidget {
  const TMBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _TMBottomNavigationBarState createState() => _TMBottomNavigationBarState();
}

class _TMBottomNavigationBarState extends State<TMBottomNavigationBar> {
  int _currentIndex = 0; // Lo deberia manejar el main.dart

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
            _currentIndex = index;
          });
        });
  }
}
