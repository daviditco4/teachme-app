import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/SubjectsKeys.dart';
import 'package:teachme_app/helpers/search_teacher_system.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/pages/notifications_page.dart';
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
  final Map<String, String> _subjectNameToID = {};
  List<String> _allSubjectsList = [""];
  String subjectSelected = "";
  final _searchSystem = SearchTeacherSystem();

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

  void _getFirebaseSubjectsList() async {
    var fbSubjects =
        FirebaseFirestore.instance.collection(SubjectsKeys.collectionName);

    QuerySnapshot querySnapshot = await fbSubjects.get();

    var docIterator = querySnapshot.docs.iterator;
    String? subjectName;
    String subjectID;
    while (docIterator.moveNext()) {
      var current = docIterator.current;
      subjectName = current[SubjectsKeys.name];
      subjectID = current.id;

      if (subjectName != null) {
        _subjectNameToID[subjectName] = subjectID;
      }
    }

    setState(() {
      _allSubjectsList = _subjectNameToID.keys.toList();

      //FIXME: El orden alfabetico puede ser muy ineficiente. Eliminar estas
      // lineas si es necesario
      _allSubjectsList.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });

      subjectSelected = _allSubjectsList[0];
    });
  }

  @override
  initState() {
    _getFirebaseSubjectsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final subjectsCollec = firestore.collection("subjects");

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
              _subjectSelector(),
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
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _searchSystem
                    .getTeachersBySubject(_subjectNameToID[subjectSelected]),
                builder: (_, snapshot) {
                  final isWaiting =
                      snapshot.connectionState == ConnectionState.waiting;
                  if (isWaiting)
                    return const Center(child: CircularProgressIndicator());

                  if (snapshot.hasData) {
                    final docs = snapshot.data!;
                    final n = docs.length;

                    return ListView.builder(
                        itemCount: n,
                        itemBuilder: (context, index) {
                          // Documento que tiene las propiedades  de Teacher
                          final documentData = docs[index];

                          return Card(
                            key: ValueKey(documentData[TeachersKeys.uid]),
                            color: MyColors.cardClass,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Text(
                                      documentData[TeachersKeys.name],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    title:
                                        Text(documentData[TeachersKeys.name]),
                                    subtitle: Text('Se encuentra a '),
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
                                        itemCount:
                                            documentData[TeachersKeys.rating]
                                                .round(),
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => const Icon(
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
                                            "",
                                            double.parse(documentData[
                                                    TeachersKeys.classPrice]
                                                .toString())),
                                        child: const Text('Reservar clases'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    MyColors.buttonCardClass),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    side: const BorderSide(
                                                        color: Colors.white)))),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
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

  Widget _subjectSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<String>(
          value: subjectSelected,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              if (newValue != null) {
                subjectSelected = newValue;
              }
            });
          },
          items: _allSubjectsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                // changedSubject = true;
              });
            },
            icon: const Icon(
              Icons.check_circle,
              color: MyColors.buttonCardClass,
            ))
      ],
    );
  }
}
