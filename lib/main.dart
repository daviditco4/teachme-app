import 'package:flutter/material.dart';

import 'pages/teacher_profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeachMe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TeacherProfilePage(),
    );
  }
}
