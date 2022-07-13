import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/pages/geolocation/current_location_screen.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/auth/profile_service.dart';
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
  bool isLoading = true;
  bool _isEditingText = false;
  late TextEditingController _editingController;
  String initialText = "";
  List<String> commentList = [];
  int commentIndex = 0;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _profileService.getProfile(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snap) {
          if (snap.connectionState == ConnectionState.waiting ||
              !snap.hasData) {
            isLoading = true;
          } else {
            Map<String, dynamic> studentData = snap.data!;
            initialText = studentData[StudentsKeys.description];
            _editingController.text = studentData[StudentsKeys.description];
            List<dynamic> aux = studentData[StudentsKeys.comments];
            commentList = aux.cast<String>();

            isLoading = false;
          }

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
                                              ElevatedButton(
                                                onPressed: () => {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CurrentLocationScreen(
                                                                positionChanged:
                                                                    (position) {
                                                                  _profileService
                                                                      .updatePosition(
                                                                          position);
                                                                },
                                                              ))),
                                                },
                                                child: const Text(
                                                    "Usar ubicación actual"),
                                                style:
                                                    MyColors.buttonStyleDefault,
                                              ),
                                              const SizedBox(height: 10.0),
                                              const Divider(
                                                height: 40.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 32.0, right: 32.0),
                                                child: Align(
                                                    child: Center(
                                                  child: Row(children: [
                                                    Expanded(
                                                        child: !_isEditingText
                                                            ? Text(initialText)
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
                                                                  setState(() =>
                                                                      {
                                                                        _isEditingText =
                                                                            false,
                                                                        initialText =
                                                                            value
                                                                      });
                                                                })),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
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
                                              Column(
                                                children: <Widget>[
                                                  const Text(
                                                    "Comentarios",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color: MyColors.black),
                                                  ),
                                                  const SizedBox(height: 25.0),
                                                  SizedBox(
                                                      height:
                                                          200, // card height
                                                      child: PageView.builder(
                                                          itemCount: commentList
                                                              .length,
                                                          controller:
                                                              PageController(
                                                                  viewportFraction:
                                                                      0.85),
                                                          onPageChanged: (int
                                                                  index) =>
                                                              setState(() =>
                                                                  commentIndex =
                                                                      index),
                                                          itemBuilder: (_, i) {
                                                            return Transform
                                                                .scale(
                                                                    scale: i ==
                                                                            commentIndex
                                                                        ? 1
                                                                        : 0.9,
                                                                    child: Card(
                                                                      elevation:
                                                                          6,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(10.0),
                                                                        child:
                                                                            Text(
                                                                          commentList[
                                                                              commentIndex],
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ));
                                                          }))
                                                ],
                                              ),
                                              const SizedBox(height: 25.0),
                                              const Divider(
                                                height: 20.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
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
                ),
                Visibility(
                  visible: isLoading,
                  maintainInteractivity: false,
                  child: const Center(
                    child: CircularProgressIndicator(
                        color: MyColors.buttonCardClass),
                  ),
                )
              ]));
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
