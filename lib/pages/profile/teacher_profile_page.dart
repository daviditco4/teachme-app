import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/subject_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/pages/geolocation/current_location_screen.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:teachme_app/widgets/edit_subjects_popup.dart';
import 'package:teachme_app/widgets/auth/profile_service.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import '../../widgets/other/tm_navigator.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

const String preferenceID = "425735901-07679a17-ebfb-43b9-8ef4-e29d557b1200";
const String publicKey = "APP_USR-574f4f04-1b72-4b6f-acee-bbde68af6db3";

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ProfileService _profileService = ProfileService();
  bool _isEditingText = false;
  bool _isEditingText2 = false;
  late TextEditingController _editingController;
  String initialText = "";
  String classPrice = "";
  User user = FirebaseAuth.instance.currentUser!;
  String availableFrom = "...";
  String availableUpTo = "...";
  String dropdownValueFrom = "00:00";
  String dropdownValueUpTo = "23:00";
  List<bool> availableDays = List.filled(7, true);
  List<String> subjects = [];
  bool isLoading = true;
  double teacherRating = 0;
  double teacherDebt = 0;
  int commentIndex = 0;
  List<String> commentList = [];

  static final Map<int, String> indexToDayMap = {
    0: "Domingo",
    1: "Lunes",
    2: "Martes",
    3: "Miércoles",
    4: "Jueves",
    5: "Viernes",
    6: "Sábado"
  };
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
    super.initState();
    _getSubjects();
    _getAvailableHours();
    _getAvailableWeekdays();
    _getClassPrice();
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
          if (snap.connectionState == ConnectionState.waiting ||
              !snap.hasData) {
            isLoading = true;
          } else {
            Map<String, dynamic> teacherData = snap.data!;

            initialText = teacherData[TeachersKeys.description];
            _editingController.text = teacherData[TeachersKeys.description];
            teacherRating = teacherData[TeachersKeys.rating];
            teacherDebt = teacherData[TeachersKeys.debt];
            List<dynamic> aux = teacherData[TeachersKeys.comments];
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
                  child: Stack(children: [
                    ListView(children: [
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
                                                    onPressed: () {
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
                                                                  )));
                                                    },
                                                    style: MyColors
                                                        .buttonStyleDefault,
                                                    child: const Text(
                                                        "Usar ubicación actual")),
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
                                                            _editSubjectPopup(
                                                                context,
                                                                'Editar Materias',
                                                                'Cancelar',
                                                                'Aceptar'),
                                                        child: const Text(
                                                            'Editar'),
                                                        style: MyColors
                                                            .buttonStyleDefault,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Wrap(
                                                      alignment:
                                                          WrapAlignment.start,
                                                      spacing: 5.0,
                                                      children:
                                                          _generateSubjectChips(
                                                              subjects)),
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
                                                        initialRating:
                                                            teacherRating,
                                                        itemSize: 25,
                                                        minRating: 0,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        ignoreGestures: true,
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
                                                        onRatingUpdate: (_) {},
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
                                                Column(
                                                  children: <Widget>[
                                                    const Text(
                                                      "Comentarios",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                    const SizedBox(
                                                        height: 25.0),
                                                    SizedBox(
                                                        height:
                                                            200, // card height
                                                        child: PageView.builder(
                                                            itemCount:
                                                                commentList
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
                                                            itemBuilder:
                                                                (_, i) {
                                                              return Transform
                                                                  .scale(
                                                                      scale: i ==
                                                                              commentIndex
                                                                          ? 1
                                                                          : 0.9,
                                                                      child:
                                                                          Card(
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
                                                                            commentList[commentIndex],
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
                                                        "Horarios Disponibles",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0,
                                                            color:
                                                                MyColors.black),
                                                      ),
                                                      ElevatedButton(
                                                        child: const Text(
                                                            'Editar'),
                                                        style: MyColors
                                                            .buttonStyleDefault,
                                                        onPressed: () => showDialog<
                                                                bool>(
                                                            context: context,
                                                            builder: (context) =>
                                                                StatefulBuilder(
                                                                  builder: (context,
                                                                          setState) =>
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
                                                                            "Seleccione qué días está disponible"),
                                                                        WeekdaySelector(
                                                                            onChanged: (int
                                                                                day) {
                                                                              setState(() {
                                                                                // Los dias estan numerados del 1 al 7
                                                                                int index = day % 7;

                                                                                availableDays[index] = !availableDays[index];
                                                                              });
                                                                            },
                                                                            values:
                                                                                availableDays),
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
                                                                  ),
                                                                )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    "Días: " +
                                                        _availableWeekdaysToString(
                                                            availableDays),
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        color: MyColors.black),
                                                    textAlign:
                                                        TextAlign.center),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      "Horarios: " +
                                                          availableFrom +
                                                          " a " +
                                                          availableUpTo,
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color:
                                                              MyColors.black),
                                                      textAlign:
                                                          TextAlign.center),
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
                                                      "Precio por Clase",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color:
                                                              MyColors.black),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 32.0,
                                                              right: 32.0),
                                                      child: Align(
                                                        child: Row(children: [
                                                          Expanded(
                                                              child:
                                                                  !_isEditingText2
                                                                      ? Text(
                                                                          classPrice,
                                                                          style:
                                                                              const TextStyle(fontSize: 15),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )
                                                                      : TextFormField(
                                                                          validator:
                                                                              ((value) {
                                                                            if (value ==
                                                                                null) {
                                                                              return "Debe ingresar un valor";
                                                                            }
                                                                            int aux =
                                                                                int.parse(value);
                                                                            if (aux <=
                                                                                0) {
                                                                              return "Precio inválido";
                                                                            }
                                                                            return null;
                                                                          }),
                                                                          decoration: const InputDecoration(
                                                                              labelStyle: TextStyle(
                                                                                  color: Colors
                                                                                      .black),
                                                                              labelText:
                                                                                  "Ingresa un nuevo precio"),
                                                                          keyboardType: TextInputType
                                                                              .number,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.digitsOnly
                                                                          ],
                                                                          initialValue:
                                                                              classPrice,
                                                                          textInputAction: TextInputAction
                                                                              .done,
                                                                          onFieldSubmitted:
                                                                              (value) {
                                                                            setState(() =>
                                                                                {
                                                                                  _isEditingText2 = false,
                                                                                  classPrice = value
                                                                                });
                                                                            _handleChangedClassPrice();
                                                                          })),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.edit),
                                                            onPressed: () {
                                                              setState(() => {
                                                                    _isEditingText2 =
                                                                        true,
                                                                  });
                                                            },
                                                          )
                                                        ]),
                                                      ),
                                                    )
                                                  ],
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
                                                        "Deuda", //otro nombre para esto
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0,
                                                            color:
                                                                MyColors.black),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            createOrder({
                                                          "price": teacherDebt,
                                                          "preference_id":
                                                              preferenceID,
                                                          "user": firebaseAuth
                                                              .currentUser!.uid
                                                        }),
                                                        child:
                                                            const Text('Pagar'),
                                                        style: MyColors
                                                            .buttonStyleDefault,
                                                      ),
                                                    ],
                                                  ),
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
                                                      Text(
                                                        "\$" +
                                                            teacherDebt
                                                                .toStringAsFixed(
                                                                    2), //poner el dato de firebase
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0,
                                                            color:
                                                                MyColors.black),
                                                      ),
                                                    ],
                                                  ),
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
                    Visibility(
                      visible: isLoading,
                      maintainInteractivity: false,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: MyColors.buttonCardClass),
                      ),
                    ),
                  ]),
                )
              ]));
        });
  }

  //TODO: Implementar
  void _updateLocation() {}

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

  void _setAvailableWeekdays() async {
    await FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(user.uid)
        .update({TeachersKeys.availableDays: availableDays});
    _getAvailableWeekdays();
  }

  void _getAvailableWeekdays() async {
    var document = FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(user.uid);

    await document.get().then((document) => {
          setState(() {
            List<dynamic> firebaseAvailableDays =
                document[TeachersKeys.availableDays];

            availableDays = firebaseAvailableDays.cast<bool>();
          })
        });
  }

  String _availableWeekdaysToString(List<bool> availableWeekdays) {
    List<String> availableDaysStrings = [];
    String out = "";

    for (int i = 0; i < availableWeekdays.length; ++i) {
      if (availableWeekdays[i]) {
        availableDaysStrings.add(indexToDayMap[i]!);
      }
    }

    switch (availableDaysStrings.length) {
      case 0:
        out = "El profesor no tiene días disponibles";
        break;
      case 1:
        out = availableDaysStrings[0];
        break;
      default:
        int i;
        out += availableDaysStrings[0];
        for (i = 1; i < availableDaysStrings.length - 1; ++i) {
          out += ", " + availableDaysStrings[i];
        }
        out += " y " + availableDaysStrings[i];
    }

    return out;
  }

  String _roundHourFromString(String s) {
    int aux = int.parse(s);

    if (aux < 10) return "0" + s + ":00";

    return s + ":00";
  }

  void _getAvailableHours() async {
    var document = FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(user.uid);

    await document.get().then((document) => {
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
      print(e);
    }

    _getAvailableHours();
  }

  void _handleChangedAvailableHours() {
    int from = int.parse(dropdownValueFrom.replaceAll(":00", ""));
    int to = int.parse(dropdownValueUpTo.replaceAll(":00", ""));

    //TODO: Mostrar mensaje de horario invalido
    if (to < from) return;

    _setAvailableWeekdays();
    _setAvailableHours(from.toString(), to.toString());
    Navigator.pop(context, true);
  }

  void _handleChangedClassPrice() async {
    try {
      await FirebaseFirestore.instance
          .collection(TeachersKeys.collectionName)
          .doc(user.uid)
          .update({TeachersKeys.classPrice: double.parse(classPrice)});
    } on Exception catch (e) {
      print(e);
    }

    _getClassPrice();
  }

  void _getClassPrice() async {
    var document = FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(user.uid);

    await document.get().then((document) => {
          setState(() {
            classPrice = document[TeachersKeys.classPrice].toString();
          })
        });
  }

  void _editSubjectPopup(
      BuildContext context, String title, String b1, String b2) async {
    await showDialog<bool>(
        context: context,
        builder: (context) => EditSubjectPopup(
              title: title,
              button1: b1,
              button2: b2,
              teacherSubjectsList: subjects,
            ));

    _getSubjects();
  }

  void _getSubjects() async {
    List<String> subjectIDs = [];
    var firestore = FirebaseFirestore.instance;

    List<dynamic> aux = [];
    await firestore
        .collection(TeachersKeys.collectionName)
        .doc(user.uid)
        .get()
        .then((document) => {
              aux = document[TeachersKeys.subjects],
              subjectIDs = aux.cast<String>()
            });

    List<String> subjectNames = [];
    var subjectCollection = firestore.collection(SubjectsKeys.collectionName);

    for (String subjectID in subjectIDs) {
      await subjectCollection
          .doc(subjectID)
          .get()
          .then((document) => {subjectNames.add(document[SubjectsKeys.name])});
    }

    //FIXME: Orden alfabetico. Puede ser ineficiente
    subjectNames.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    setState(() {
      subjects = subjectNames;
    });
    print(subjects);
  }

  List<Widget> _generateSubjectChips(List<String> subjectNames) {
    List<Chip> chipList = [];

    for (String subjectName in subjectNames) {
      Chip newChip = Chip(
        padding: const EdgeInsets.all(8),
        backgroundColor: MyColors.background,
        shadowColor: Colors.black,
        label: Text(
          subjectName,
          style: const TextStyle(fontSize: 16),
        ), //Text
      );

      chipList.add(newChip);
    }

    return chipList;
  }

  createOrder(Map<String, dynamic> orderData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OrderScreen(orderData: orderData);
    }));
  }
}

class OrderScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const OrderScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _loading = true;
  bool _paying = false;
  String _message = "";

  late StreamSubscription<DocumentSnapshot> subscription;

  @override
  void initState() {
    super.initState();

    createOrder();
  }

  createOrder() async {
    var paymentRef = FirebaseFirestore.instance.collection('payments').doc();

    await paymentRef.set(widget.orderData);

    paymentRef.snapshots().listen(onData);
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_loading)
              Text("Preparando tu pago de: \$ ${widget.orderData['price']}"),
            const SizedBox(
              height: 18,
            ),
            if (_loading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(_message) // cambiar
                  )
          ],
        ),
      ),
    );
  }

  void onData(DocumentSnapshot<Map<String, dynamic>> event) async {
    if (event.data()!['result'] == 'done') {
      setState(() {
        _loading = false;
        _message = "Gracias por el pago";
      });
    } else if (event.data()!['result'] == 'canceled') {
      setState(() {
        _loading = false;
        _message = "Se cancelo el pago";
      });
    } else if (_paying == false) {
      if (event.data()!.containsKey('preference_id')) {
        var result = await MercadoPagoMobileCheckout.startCheckout(
            publicKey, event.data()!['preference_id']);
        event.reference.set({
          'result': result.result,
          'status': result.status,
          'statusDetails': result.statusDetail,
          'paymentMethodId': result.paymentMethodId
        }, SetOptions(merge: true));
      }
    }
  }
}
