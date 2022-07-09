import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/SubjectsKeys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';

class EditSubjectPopup extends StatefulWidget {
  final String title;
  final String button1;
  final String button2;
  final List<String> teacherSubjectsList;

  const EditSubjectPopup(
      {Key? key,
      required this.title,
      required this.button1,
      required this.button2,
      required this.teacherSubjectsList})
      : super(key: key);

  @override
  State<EditSubjectPopup> createState() => _EditSubjectPopup();
}

class _EditSubjectPopup extends State<EditSubjectPopup> {
  String dropdownValue = 'Cargando...';
  int dropdownPrice = 950;
  late List<String> teacherSubjectsList;
  List<String> allSubjectsList = ['Cargando...'];
  Map<String, String> subjectNameToID = {};
  List<String> subjectsToRemove = [];
  List<String> subjectsToAdd = [];
  bool isAddingSubject = false;

  @override
  void initState() {
    super.initState();
    _getFirebaseSubjectsList();
  }

  @override
  Widget build(BuildContext context) {
    teacherSubjectsList = widget.teacherSubjectsList;

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Colors.white)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.black,
                      fontSize: 25,
                    )),
              ),
              const SizedBox(height: 10.0),
              const Text('Materias que enseñas actualmente: ',
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 17,
                  )),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Wrap(
                  spacing: 5.0,
                  children: _generateSubjectsTexts(teacherSubjectsList),
                ),
              ),
              Container(
                  child: isAddingSubject
                      ? _subjectSelector()
                      : _addSubjectButton()),
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
                    onPressed: () => /* _handleAddNewSubject(dropdownValue) */
                        _handleUpdatedTeacherSubjectsList(teacherSubjectsList,
                            subjectsToRemove, subjectsToAdd),
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
      allSubjectsList = subjectNameToID.keys.toList();

      //FIXME: El orden alfabetico puede ser muy ineficiente. Eliminar estas
      // lineas si es necesario
      allSubjectsList.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });

      dropdownValue = allSubjectsList[0];
    });
  }

  void _handleAddNewSubject(String subjectName) {
    print("Intentando agregar " + subjectName);
    if (teacherSubjectsList.contains(subjectName)) {
      return;
    }

    setState(() {
      teacherSubjectsList.add(subjectName);
    });
    subjectsToRemove.remove(subjectNameToID[subjectName]!);
    subjectsToAdd.add(subjectNameToID[subjectName]!);
  }

  void _handleUpdatedTeacherSubjectsList(List<String> updatedTeacherSubjectList,
      List<String> subjectsToRemove, List<String> subjectsToAdd) async {
    Navigator.pop(context, false);

    String teacherUID = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;
    List<String> auxTeacherList = [teacherUID];

    updatedTeacherSubjectList = updatedTeacherSubjectList
        .map((subjectName) => subjectNameToID[subjectName]!)
        .toList();
    await firestore
        .collection(TeachersKeys.collectionName)
        .doc(teacherUID)
        .update({TeachersKeys.subjects: updatedTeacherSubjectList});

    var subjectsCol = firestore.collection(SubjectsKeys.collectionName);

    for (String subjectID in subjectsToRemove) {
      subjectsCol.doc(subjectID).update(
          {SubjectsKeys.teachers: FieldValue.arrayRemove(auxTeacherList)});
    }

    for (String subjectID in subjectsToAdd) {
      subjectsCol.doc(subjectID).update(
          {SubjectsKeys.teachers: FieldValue.arrayUnion(auxTeacherList)});
    }
  }

  List<Widget> _generateSubjectsTexts(List<String> teacherSubjectsList) {
    List<Widget> subjectRows = [];

    for (String subjectName in teacherSubjectsList) {
      subjectRows.add(subjectRow(subjectName));
    }

    return subjectRows;
  }

  Widget subjectRow(String subjectName) {
    return Chip(
      label: Text(subjectName),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () => _removeFromSubjectsList(subjectName),
    );
  }

  void _removeFromSubjectsList(String subjectName) {
    setState(() {
      teacherSubjectsList.remove(subjectName);
    });
    subjectsToAdd.remove(subjectNameToID[subjectName]!);
    subjectsToRemove.add(subjectNameToID[subjectName]!);
  }

  Widget _subjectSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: allSubjectsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        IconButton(
            onPressed: () {
              _handleAddNewSubject(dropdownValue);
              setState(() {
                isAddingSubject = false;
              });
            },
            icon: const Icon(
              Icons.check_circle,
              color: MyColors.buttonCardClass,
            ))
      ],
    );
  }

  Widget _addSubjectButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      TextButton(
          onPressed: () {
            setState(() {
              isAddingSubject = true;
            });
          },
          child: const Text(
            "Agregar Materia",
            style: TextStyle(fontSize: 16, color: MyColors.buttonCardClass),
          )),
      IconButton(
          onPressed: () {
            setState(() {
              isAddingSubject = true;
            });
          },
          icon: Icon(Icons.add))
    ]);
  }
}
