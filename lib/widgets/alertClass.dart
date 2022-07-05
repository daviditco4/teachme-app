import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';

import '../constants/theme.dart';
import '../helpers/classes_keys.dart';
import '../helpers/students_keys.dart';

class AlertClass extends StatefulWidget {
  final String title;
  final String subTitle;
  final String teacherUid;
  final String subjectId;

  const AlertClass(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.teacherUid,
      required this.subjectId})
      : super(key: key);

  @override
  State<AlertClass> createState() => _AlertClass();
}

class _AlertClass extends State<AlertClass> {
  String dropdownValue = 'hh:mm';
  List<String> availableHours = ['hh:mm'];

  @override
  void initState() {
    _getTeacherAvailableHours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.zero,
      content: Row(
        children: <Widget>[
          Text(widget.subTitle),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: availableHours.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(MyColors.buttonCardClass)),
        ),
        ElevatedButton(
          onPressed: () => _handleBookedClass(
              context, widget.teacherUid, widget.subjectId, dropdownValue),
          child: const Text('Si'),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(MyColors.buttonCardClass)),
        ),
      ],
    );
  }

  void _getTeacherAvailableHours() async {
    int availableFrom;
    int availableUpTo;

    var document = FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(widget.teacherUid);

    await document.get().then((document) => {
          availableFrom = int.parse(document[TeachersKeys.availableFrom]),
          availableUpTo = int.parse(document[TeachersKeys.availableUpTo]),
          setState(() {
            availableHours = [];
            for (int hour = availableFrom; hour <= availableUpTo; ++hour) {
              availableHours.add(hour.toString() + ":00");
            }
            dropdownValue = availableHours[0];
          })
        });
  }
}

void _handleBookedClass(
    BuildContext context, String teacherUid, String subjectId, String time) {
  Navigator.pop(context, true);
  _updateClassesCollection(teacherUid, subjectId, time);
}

void _updateClassesCollection(
    String teacherUid, String subjectId, String time) async {
  try {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection(StudentsKeys.collectionName)
        .doc(user.uid)
        .collection(ClassesKeys.collectionName)
        .add({
      //ClassesKeys.studentUid: user.uid,
      //TODO: Campo Date
      ClassesKeys.teacherUid: teacherUid,
      ClassesKeys.time: time,
      ClassesKeys.subjectId: subjectId,
      ClassesKeys.cost: 'to be determined'
    });

    await FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(teacherUid)
        .collection(ClassesKeys.collectionName)
        .add({
      ClassesKeys.studentUid: user.uid,
      //ClassesKeys.teacherUid: teacherUid,
      ClassesKeys.time: time,
      ClassesKeys.subjectId: subjectId,
      ClassesKeys.cost: 'to be determined'
    });
  } on Exception catch (e) {
    /* print("MALARDOOOO"); */
    print(e);
  }
}
