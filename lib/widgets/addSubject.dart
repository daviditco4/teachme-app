import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/SubjectsKeys.dart';
import 'package:teachme_app/helpers/classes_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/widgets/auth/auth_form.dart';

class AddSubject extends StatefulWidget {
  final String title;
  final String button1;
  final String button2;

  const AddSubject(
      {Key? key,
      required this.title,
      required this.button1,
      required this.button2})
      : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubject();
}

class _AddSubject extends State<AddSubject> {
  String dropdownValue = 'Cargando...';
  int dropdownPrice = 950;
  List<String> subjectList = ['Cargando...'];
  Map<String, String> subjectNameToID = {};

  bool _expanded1 = false;
  bool _expanded2 = false;

  @override
  void initState() {
    super.initState();
    _getFirebaseSubjectsList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Colors.white)),
        /*child:Container(
          height: 350,
          child: Column(
              children: <Widget>[
                Container(
                  child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Agregar',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text('Selecciona alguna de las siguientes materias: ',
                                    style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 17,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: <String>['Matematica Discreta', 'Analisis Matematico', 'Programación', 'Biologia']
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    DropdownButton<int>(
                                      value: dropdownPrice,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          dropdownPrice = newValue!;
                                        });
                                      },
                                      items: <int>[950, 1000, 1200]
                                          .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Agregar'),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        isExpanded: _expanded1,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: MyColors.bottomNavBarBackground,
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded1 = !_expanded1;
                      setState(() {});
                    },
                  ),

                ),
                Container(
                  child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Editar',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text('Selecciona alguna de las siguientes materias: ',
                                    style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 17,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: <String>['Matematica Discreta', 'Analisis Matematico', 'Programación', 'Biologia']
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    DropdownButton<int>(
                                      value: dropdownPrice,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          dropdownPrice = newValue!;
                                        });
                                      },
                                      items: <int>[950, 1000, 1200]
                                          .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Eliminar'),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Guardar'),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        isExpanded: _expanded2,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: MyColors.bottomNavBarBackground,
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded2 = !_expanded2;
                      setState(() {});
                    },
                  ),
                ),
              ],
          ),

        ),*/
        child: Container(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,
                  style: const TextStyle(
                    color: MyColors.black,
                    fontSize: 25,
                  )),
              const SizedBox(height: 10.0),
              const Text('Selecciona alguna de las siguientes materias: ',
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 17,
                  )),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: subjectList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(widget.button1),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.defaultColor)),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleAddNewSubject(dropdownValue),
                    child: Text(widget.button2),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MyColors.buttonCardClass)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
        subjectNameToID[subjectName] = subjectID;
      }
    }

    setState(() {
      subjectList = subjectNameToID.keys.toList();

      //FIXME: El orden alfabetico puede ser muy ineficiente. Eliminar estas
      // lineas si es necesario
      subjectList.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });

      dropdownValue = subjectList[0];
    });
  }

  void _handleAddNewSubject(String subjectName) async {
    Navigator.pop(context, false);

    String? subjectID = subjectNameToID[subjectName];
    if (subjectID == null) return;

    String teacherUID = FirebaseAuth.instance.currentUser!.uid;
    List<String> auxSubjectList = [subjectID];
    List<String> auxTeacherList = [teacherUID];

    var firestore = FirebaseFirestore.instance;

    await firestore
        .collection(TeachersKeys.collectionName)
        .doc(teacherUID)
        .update({TeachersKeys.subjects: FieldValue.arrayUnion(auxSubjectList)});

    await firestore
        .collection(SubjectsKeys.collectionName)
        .doc(subjectID)
        .update({SubjectsKeys.teachers: FieldValue.arrayUnion(auxTeacherList)});
  }
}
