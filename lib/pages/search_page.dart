import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/SubjectsKeys.dart';
import 'package:teachme_app/helpers/classes_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/widgets/auth/auth_form.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/custom_autocomplete.dart';
import 'package:teachme_app/widgets/other/tm_navigator.dart';
import 'package:teachme_app/widgets/alertClass.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Search',
      home: SearchPage(),
    );
  }
}

 */

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  //late String selectedValue;

  void showWarning(BuildContext context, String teacherUid, String subjectId,
      double classPrice) async {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertClass(
          title: '¿Querés reservar la clase?',
          subTitle: 'Seleccioná una fecha y horario disponibles: ',
          teacherUid: teacherUid,
          subjectId: subjectId,
          classPrice: classPrice),
    );
  }

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Martin Perez", "km": 1.3, "price": 1300},
    {"id": 2, "name": "Lucia Gomez", "km": 2.7, "price": 1800},
    {"id": 3, "name": "Juan Gutierrez", "km": 3, "price": 900},
    {"id": 4, "name": "Martina Ramirez", "km": 5.3, "price": 1000},
    {"id": 5, "name": "Federico Botti", "km": 1.1, "price": 1500},
  ];

  final List<String> subjects = [
    "Analisis matematico 1",
    "Biologia eucariota",
    "Catequesis",
    "otras mas"
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    final subjectsCollec = firestore.collection("subjects");
    final teachersCollec = firestore.collection("teachers");

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.background,
      bottomNavigationBar: TMBottomNavigationBar(),
      appBar: AppBar(
        leading: const ImageIcon(
          AssetImage("assets/images/teach_me_logo.png"),
          color: MyColors.buttonCardClass,
        ),
        centerTitle: true,
        title: const Text('Busca tu clase',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () => TMNavigator.navigateToPage(
                  context, const NotificationsPage()),
            ),
          ),
        ],
        backgroundColor: MyColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              /* TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Buscar', suffixIcon: Icon(Icons.search)),
              ), */
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: subjectsCollec.snapshots(),
                  builder: (_, snap) {
                    final isWaiting =
                        snap.connectionState == ConnectionState.waiting;
                    if (isWaiting)
                      return const Center(child: CircularProgressIndicator());
                    if (snap.hasData) {
                      final docs = snap.data!.docs;

                      List<String> subjects = [];
                      for (var document in docs) {
                        final data = document.data();
                        subjects.add(data[SubjectsKeys.name]);
                      }
                      return CustomAutocomplete(kOptions: subjects);
                    } else {
                      return const SizedBox(
                        width: 200,
                        height: 200,
                      );
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Filtrar por: '),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.buttonCardClass),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(color: Colors.white)))),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Ordenar por distancia'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.buttonCardClass),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(color: Colors.white)))),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: teachersCollec.snapshots(),
                builder: (_, snapshot) {
                  final isWaiting =
                      snapshot.connectionState == ConnectionState.waiting;
                  if (isWaiting)
                    return const Center(child: CircularProgressIndicator());

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    final n = docs.length;

                    return ListView.builder(
                        itemCount: n,
                        itemBuilder: (context, index) {
                          // Documento que tiene las propiedades  de Teacher
                          final document = docs[index];
                          final documentData = document.data();
                          final subjectsData =
                              documentData[TeachersKeys.subjects]
                                  as List<dynamic>;

                          /*
                          FIXME: Tomar el nombre/sid de la materia desde el custom
                           */
                          for (var subject in subjectsData) {
                            if (subject["sid"] == "LTtGqXljp13JMSk1jDA1") {
                              return Card(
                                key: ValueKey(documentData[TeachersKeys.uid]),
                                color: MyColors.cardClass,
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Text(
                                          documentData[TeachersKeys.name],
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        title: Text(
                                            documentData[TeachersKeys.name]),
                                        subtitle: Text(
                                            'Se encuentra a ${subject["price"]} km'),
                                        trailing: Text(
                                            '\$ ${documentData["classPrice"] ?? 0}'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          RatingBar.builder(
                                            initialRating: 1,
                                            itemSize: 25,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: documentData[
                                                    TeachersKeys.rating]
                                                .round(),
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: MyColors.white,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          ElevatedButton(
                                            onPressed: () => showWarning(
                                                context,
                                                documentData[TeachersKeys.uid],
                                                subject['sid'],
                                                double.parse(documentData[
                                                        TeachersKeys.classPrice]
                                                    .toString())),
                                            child:
                                                const Text('Reservar clases'),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        MyColors
                                                            .buttonCardClass),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .white)))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                          return const SizedBox(width: 0, height: 0);
                        });
                  } else {
                    return const SizedBox(width: 200, height: 200);
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
