import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../constants/Theme.dart';
import '../helpers/classes_keys.dart';

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
  String dropdownValue = '12:30';

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
            items: <String>['12:30', '13:30', '14:30', '15:30']
                .map<DropdownMenuItem<String>>((String value) {
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
    // TODO: El horario deberia ser un timestamp
    await FirebaseFirestore.instance
        .collection(ClassesKeys.collectionName)
        .add({
      ClassesKeys.studentUid: user.uid,
      ClassesKeys.teacherUid: teacherUid,
      ClassesKeys.time: time,
      ClassesKeys.subjectId: subjectId
    });
  } on Exception catch (e) {
    /* print("MALARDOOOO"); */
    print(e);
  }
}
