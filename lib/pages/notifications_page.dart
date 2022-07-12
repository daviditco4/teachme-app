import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/classes_keys.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/main.dart';
import 'package:teachme_app/pages/my_classes_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/notification.dart';

import '../widgets/other/tm_navigator.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Widget> notifications = [];
  DateTime localDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _generateNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        bottomNavigationBar: const TMBottomNavigationBar(),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () =>
                  TMNavigator.navigateToPage(context, const MyClass())),
          title: const Text('Notificaciones',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
          backgroundColor: MyColors.background,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: notifications,
              ),
            ),
          ),
        ));
  }

  String _formatDateTime(String date, String time) {
    return "$date $time:00:00.000";
  }

  bool _classFinished(DateTime classTime) {
    // Si paso una hora de la clase
    return localDateTime.isAfter(classTime.add(const Duration(hours: 1)));
  }

  void _generateNotifications() async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    User user = FirebaseAuth.instance.currentUser!;

    bool isStudent = userProfileType.value == ProfileType.student;
    String userCollectionName =
        isStudent ? StudentsKeys.collectionName : TeachersKeys.collectionName;

    var classesCol = await store
        .collection(userCollectionName)
        .doc(user.uid)
        .collection(ClassesKeys.collectionName)
        .get();

    var docIterator = classesCol.docs.iterator;

    while (docIterator.moveNext()) {
      var current = docIterator.current;
      String date = current[ClassesKeys.date];
      String time = current[ClassesKeys.time];
      bool teacherConfirmed = current[ClassesKeys.teacherConfirmed];
      bool studentConfirmed = current[ClassesKeys.teacherConfirmed];
      String otherUserUid = isStudent
          ? current[ClassesKeys.teacherUid]
          : current[ClassesKeys.studentUid];

      String formattedDateTime = _formatDateTime(date, time);
      DateTime classTime = DateTime.parse(formattedDateTime);

      if (_classFinished(classTime)) {
        bool currentUserConfirmed =
            isStudent ? studentConfirmed : teacherConfirmed;

        bool otherUserConfirmed =
            isStudent ? teacherConfirmed : studentConfirmed;

        if (!currentUserConfirmed) {
          _addNewNotificationCard(
              otherUserUid,
              localDateTime
                  .difference(classTime.add(const Duration(hours: 1)))
                  .inHours);
        }
      }
    }
  }

  void _addNewNotificationCard(String otherUserUid, int timeAgo) async {
    bool isStudent = userProfileType.value == ProfileType.student;
    String username = "Username";
    String imgUrl = "";

    FirebaseFirestore store = FirebaseFirestore.instance;
    String otherUserCollectionName =
        isStudent ? TeachersKeys.collectionName : StudentsKeys.collectionName;

    await store
        .collection(otherUserCollectionName)
        .doc(otherUserUid)
        .get()
        .then((doc) {
      username = doc["name"];
      imgUrl = doc["photoUrl"];
    });

    TMNotification newNotif = TMNotification(
        username: username, imgUrl: imgUrl, timeAgo: timeAgo.toString());

    setState(() {
      notifications.add(newNotif);
    });
  }
}
