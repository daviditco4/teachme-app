import 'package:flutter/material.dart';
import 'package:teachme_app/pages/MyClass_page.dart';
import 'package:teachme_app/pages/auth_page.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/pages/log_in_page.dart';
import 'package:teachme_app/pages/loading_page.dart';

import 'pages/lesson_search/teacher_profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeachMe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoadingPage(),
    );
  }
}
