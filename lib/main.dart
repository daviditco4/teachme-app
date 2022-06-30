import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/firebase_options.dart';
import 'package:teachme_app/pages/my_classes_page.dart';
import 'package:teachme_app/pages/auth_page.dart';
import 'package:teachme_app/pages/messages/chat_page.dart';
import 'package:teachme_app/pages/profile/student_profile_page.dart';
import 'package:teachme_app/pages/splash_page.dart';
import 'package:teachme_app/pages/profile/teacher_profile_page.dart';

import 'pages/loading_page.dart';
import 'pages/notifications_page.dart';
import 'pages/settings_page.dart';

const chatTopic = 'public';

enum ProfileType { student, teacher, missing }

// var userProfileType = ProfileType.missing;
ValueNotifier<ProfileType> userProfileType =
    ValueNotifier<ProfileType>(ProfileType.missing);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _getUserProfileType() {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance
          .collection("usersProfileType")
          .where("uid", isEqualTo: user.uid)
          .get()
          .then((value) {
        if (value.docs[0].data()["type"] == "student") {
          userProfileType.value = ProfileType.student;
        } else if (value.docs[0].data()["type"] == "teacher") {
          userProfileType.value = ProfileType.teacher;
        }
      });
    } catch (e) {
      userProfileType.value = ProfileType.missing;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        return GestureDetector(
            onTap: () {
              final focusScope = FocusScope.of(ctx);
              if (!focusScope.hasPrimaryFocus) focusScope.unfocus();
            },
            child: MaterialApp(
              title: 'TeachMe-app',
              theme: ThemeData(
                primaryColor: Color.fromARGB(255, 0, 42, 127),
                primaryColorDark: Color.fromARGB(255, 95, 125, 226),
                accentColor: Color(0xff00adb5),
                backgroundColor: Color(0xffeeeeee),
              ),
              routes: {
                '/loading_page': (context) => const LoadingPage(),
                '/authentication': (context) => AuthPage(),
                '/class': (context) => const MyClass(),
                '/notifications': (context) => const NotificationsPage(),
                '/settings': (context) => const SettingsPage(),
                '/teacher_profile': (context) => const TeacherProfilePage(),
                '/student_profile': (context) => const StudentProfilePage(),
                '/chat': (context) => const ChatPage(),
              },
              home: snapshot.connectionState != ConnectionState.done
                  ? SplashPage()
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (_, snap) {
                        //final fcm = FirebaseMessaging.instance;
                        print("[MAIN 51]: Buildeando stream...");
                        if (snap.connectionState == ConnectionState.waiting) {
                          //fcm.requestPermission();
                          return SplashPage();
                        } else if (snap.hasData) {
                          //fcm.unsubscribeFromTopic(CHAT_TOPIC);
                          _getUserProfileType();
                          return const MyClass();
                        } else {
                          userProfileType.value = ProfileType.missing;
                          return AuthPage();
                        }
                      },
                    ),
            ));
      },
    );
  }
}
