import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/addSubject.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import '../../widgets/other/tm_navigator.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
  String availableFrom = "...";
  String availableUpTo = "...";
  String dropdownValueFrom = "00:00";
  String dropdownValueUpTo = "23:00";

  static final List<String> availableHours = [
    "00:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00"
  ];

  @override
  void initState() {
    _getAvailableHours();

    print("DVF: " + dropdownValueFrom);
    print("AH: " + availableHours.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (_, snap) {
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
                                                      "Licenciado en Ciencias Exactas en la Universidad de Buenos Aires.",
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
                                              const Divider(
                                                height: 40.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0, left: 25.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    const Text(
                                                      "Materias",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          addSubject(context),
                                                      child:
                                                          const Text('Agregar'),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(MyColors
                                                                      .buttonCardClass),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .white)))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0,
                                                    left: 25.0,
                                                    top: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const <Widget>[
                                                    Chip(
                                                      elevation: 20,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor:
                                                          MyColors.background,
                                                      shadowColor: Colors.black,
                                                      label: Text(
                                                        'Álgebra',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ), //Text
                                                    ),
                                                    Chip(
                                                      elevation: 20,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor:
                                                          MyColors.background,
                                                      shadowColor: Colors.black,
                                                      label: Text(
                                                        'Física',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ), //Text
                                                    ), //C
                                                    Chip(
                                                      elevation: 20,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor:
                                                          MyColors.background,
                                                      shadowColor: Colors.black,
                                                      label: Text(
                                                        'Lógica',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ), //Text
                                                    ),
                                                    //C //Chip
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 25.0),
                                              const Divider(
                                                height: 40.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0, left: 25.0),
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
                                                              horizontal: 2.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: MyColors.white,
                                                      ),
                                                      onRatingUpdate: (rating) {
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
                                                padding: const EdgeInsets.only(
                                                    right: 25.0, left: 25.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    const Text(
                                                      "Horarios Disponibles",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          const Text('Editar'),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(MyColors
                                                                      .buttonCardClass),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .white)))),
                                                      onPressed: () =>
                                                          showDialog<bool>(
                                                              context: context,
                                                              builder: (_) =>
                                                                  AlertDialog(
                                                                    title: const Text(
                                                                        "Editar Horarios"),
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        const Text(
                                                                            "Seleccione de qué hora a qué hora se encuentra disponible"),
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            DropdownButton<String>(
                                                                              menuMaxHeight: 200.0,
                                                                              value: dropdownValueFrom,
                                                                              icon: const Icon(Icons.arrow_drop_down),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  if (newValue != null) {
                                                                                    dropdownValueFrom = newValue;
                                                                                  }
                                                                                });
                                                                              },
                                                                              items: availableHours.map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                            ),
                                                                            const Text("  a  "),
                                                                            DropdownButton<String>(
                                                                              value: dropdownValueUpTo,
                                                                              icon: const Icon(Icons.arrow_drop_down),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  if (newValue != null) {
                                                                                    dropdownValueUpTo = newValue;
                                                                                  }
                                                                                });
                                                                              },
                                                                              items: availableHours.map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () =>
                                                                                _handleChangedAvailableHours(),
                                                                        child: const Text(
                                                                            'Aceptar'),
                                                                        style: ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all(MyColors.buttonCardClass)),
                                                                      ),
                                                                    ],
                                                                  )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                  availableFrom +
                                                      " a " +
                                                      availableUpTo,
                                                  style: const TextStyle(
                                                      fontSize: 18.0,
                                                      color: MyColors.black),
                                                  textAlign: TextAlign.left),
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
    String? username = user.displayName;
    return username ?? "ERROR";
  }

  ImageProvider _getUserImage() {
    String? userImageUrl = user.photoURL;
    if (userImageUrl != null) {
      return NetworkImage(userImageUrl);
    } else {
      return const AssetImage("assets/images/hasbulla.png");
    }
  }

  String _roundHourFromString(String s) {
    int aux = int.parse(s);

    if (aux < 10) return "0" + s + ":00";

    return s + ":00";
  }

  void _getAvailableHours() async {
    var document = await FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(user.uid);

    document.get().then((document) => {
          setState(() {
            availableFrom =
                _roundHourFromString(document[TeachersKeys.availableFrom]);
            availableUpTo =
                _roundHourFromString(document[TeachersKeys.availableUpTo]);
            dropdownValueFrom = availableFrom;
            dropdownValueUpTo = availableUpTo;
          })
        });
  }

  void _setAvailableHours(String from, String to) async {
    try {
      await FirebaseFirestore.instance
          .collection(TeachersKeys.collectionName)
          .doc(user.uid)
          .update({
        TeachersKeys.availableFrom: from,
        TeachersKeys.availableUpTo: to
      });
    } on Exception catch (e) {
      /* print("MALARDOOOO"); */
      print(e);
    }

    _getAvailableHours();
  }

  void _handleChangedAvailableHours() {
    Navigator.pop(context, true);

    int from = int.parse(dropdownValueFrom.replaceAll(":00", ""));
    int to = int.parse(dropdownValueUpTo.replaceAll(":00", ""));

    //TODO: Mostrar mensaje de horario invalido
    if (to < from) return;

    _setAvailableHours(from.toString(), to.toString());
  }

  void addSubject(BuildContext context) async {
    showDialog<bool>(context: context, builder: (context) => AddSubject());
  }
}
