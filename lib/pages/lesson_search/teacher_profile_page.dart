import 'package:flutter/material.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';

import '../../widgets/other/teacher_profile_overview.dart';
import '../../widgets/other/top_bar.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TMBottomNavigationBar(),
      appBar: TopBar(title: 'TeachMe', showSettings: true),
      body: Card(
        margin: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: TeacherProfileOverview(),
        ),
      ),
    );
  }
}
