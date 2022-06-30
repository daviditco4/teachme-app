import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/helpers/users_profile_type_keys.dart';
import 'package:teachme_app/main.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/auth/auth_form.dart';
import 'package:teachme_app/widgets/auth/auth_service.dart';
import 'package:teachme_app/widgets/auth/profile_service.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import '../../widgets/other/tm_navigator.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ProfileService _profileService = ProfileService();

  bool _isEditingText = false;
  late TextEditingController _editingController;
  String initialText = "Initial Text";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _profileService.getProfile(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snap) {
          if (!snap.hasData ||
              snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            initialText = snap.data![StudentsKeys.description];
            _editingController.text = snap.data![StudentsKeys.description];

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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32.0,
                                                          right: 32.0),
                                                  child: Align(
                                                      child: Center(
                                                    child: Row(children: [
                                                      Expanded(
                                                          child: !_isEditingText
                                                              ? Text(
                                                                  initialText)
                                                              : TextFormField(
                                                                  initialValue:
                                                                      initialText,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  onFieldSubmitted:
                                                                      (value) {
                                                                    _profileService
                                                                        .updateDescription(
                                                                            value);
                                                                    setState(
                                                                        () => {
                                                                              _isEditingText = false,
                                                                              initialText = value
                                                                            });
                                                                  })),
                                                      IconButton(
                                                        icon: Icon(Icons.edit),
                                                        onPressed: () {
                                                          setState(() => {
                                                                _isEditingText =
                                                                    true,
                                                              });
                                                        },
                                                      )
                                                    ]),
                                                  )),
                                                ),
                                                const SizedBox(height: 25.0),
                                                const Divider(
                                                  height: 40.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0,
                                                          left: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      const Text(
                                                        "Calificación",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0,
                                                            color:
                                                                MyColors.black),
                                                      ),
                                                      RatingBar.builder(
                                                        initialRating: 3,
                                                        itemSize: 25,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    2.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: MyColors.white,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 50.0),
                                                const Divider(
                                                  height: 20.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0,
                                                          left: 25.0),
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
          }
        });
  }

  String _getUsername() {
    String? username = firebaseAuth.currentUser!.displayName;
    return username ?? "";
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
