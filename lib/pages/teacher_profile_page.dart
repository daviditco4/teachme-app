import 'package:flutter/material.dart';

import '../constants/theme.dart';
import '../widgets/main_drawer.dart';
import '../widgets/nav_bar.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(title: "Profile", transparent: true),
      backgroundColor: MyColors.bgColorScreen,
      drawer: const MainDrawer(currentPage: "Profile"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('teachme_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                SafeArea(
                  bottom: false,
                  right: false,
                  left: false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/profile_photo.png",
                          ),
                          radius: 65.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            "Ryan Scheinder",
                            style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Photographer",
                            style: TextStyle(
                              color: MyColors.white.withOpacity(0.85),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            left: 42,
                            right: 32,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "2K",
                                    style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Friends",
                                    style: TextStyle(
                                      color: MyColors.white.withOpacity(0.8),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "26",
                                    style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Comments",
                                    style: TextStyle(
                                      color: MyColors.white.withOpacity(0.8),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "48",
                                    style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Bookmarks",
                                    style: TextStyle(
                                      color: MyColors.white.withOpacity(0.8),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          MyColors.white,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          MyColors.info,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              32.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Respond to button press
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 12.0,
                          right: 12.0,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text("Follow", style: TextStyle(fontSize: 13.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
