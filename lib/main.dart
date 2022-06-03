import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/firebase_options.dart';
import 'package:teachme_app/pages/MyClass_page.dart';
import 'package:teachme_app/pages/auth_page.dart';
import 'package:teachme_app/pages/messages/chat_page.dart';
import 'package:teachme_app/pages/profile_page.dart';
import 'package:teachme_app/pages/splash_page.dart';

import 'pages/loading_page.dart';
import 'pages/notifications_page.dart';
import 'pages/settings_page.dart';

const chatTopic = 'public';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                '/profile': (context) => const ProfilePage(),
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
                          return const MyClass();
                        } else {
                          return AuthPage();
                        }
                      },
                    ),
            ));
      },
    );
  }
}
