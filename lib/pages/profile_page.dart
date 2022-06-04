import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// TODO: Chequear esto
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import '../widgets/other/tm_navigator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (_, snap) {
          print(snap.data);
          return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: MyColors.background,
              bottomNavigationBar: const TMBottomNavigationBar(),
              appBar: AppBar(
                leading: const ImageIcon(
                  AssetImage("assets/images/teach_me_logo.png"),
                  color: MyColors.black,
                ),
                centerTitle: true,
                title: const Text('Mi Perfil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    )),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black),
                      onPressed: () => TMNavigator.navigateToPage(
                          context, const SettingsPage())),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none,
                          color: Colors.black),
                      onPressed: () => TMNavigator.navigateToPage(
                          context, const NotificationsPage()),
                    ),
                  ),
                ],
                backgroundColor: MyColors.background,
                elevation: 0,
              ),
              body: Stack(children: <Widget>[
                SafeArea(
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 74.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.cardClass,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Card(
                                  color: MyColors.cardClass,
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: .0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 85.0, bottom: 20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 40.0),
                                              Align(
                                                child: Text(_getUsername(),
                                                    style: const TextStyle(
                                                        color: MyColors.black,
                                                        fontSize: 28.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const SizedBox(height: 10.0),
                                              const Divider(
                                                height: 40.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 32.0, right: 32.0),
                                                child: Align(
                                                  child: Text(
                                                      "Hola!!! Actualmente estoy cursando el tercer año de ingeniería mecánica",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: MyColors.black,
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                ),
                                              ),
                                              const SizedBox(height: 25.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0, left: 25.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      "Calificación",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 100.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0, left: 25.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      "Comentarios",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 200,
                                                // child: GridView.count(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            FractionalTranslation(
                                translation: const Offset(0.0, -0.5),
                                child: Align(
                                  child: CircleAvatar(
                                    backgroundColor: MyColors.white,
                                    backgroundImage: _getUserImage(),
                                    radius: 65.0,
                                    // maxRadius: 200.0,
                                  ),
                                  alignment: const FractionalOffset(0.5, 0.0),
                                ))
                          ]),
                        ],
                      ),
                    ),
                  ]),
                )
              ]));
        });
  }

  String _getUsername() {
    String? username = firebaseAuth.currentUser!.displayName;
    return username ?? "ERROR";
  }

  ImageProvider _getUserImage() {
    String? userImageUrl = firebaseAuth.currentUser!.photoURL;
    if (userImageUrl != null) {
      return NetworkImage(userImageUrl);
    } else {
      return const AssetImage("assets/images/hasbulla.png");
    }
  }
}
