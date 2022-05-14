import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/firebase_options.dart';
import 'package:teachme_app/pages/auth_page.dart';
import 'package:teachme_app/pages/splash_page.dart';

const CHAT_TOPIC = 'public';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    const primaryColor = Color.fromARGB(255, 0, 42, 127);
    const secondaryColor = Color.fromARGB(255, 95, 125, 226)
    final defaultTextTheme = Typography.material2018().englishLike;
*/
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
              home: snapshot.connectionState != ConnectionState.done
                  ? SplashPage()
                  : AuthPage()),
        );
      },
    );
  }
}
