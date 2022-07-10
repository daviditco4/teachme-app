import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import '../constants/theme.dart';
import '../helpers/classes_keys.dart';
import '../helpers/students_keys.dart';

class AlertClass extends StatefulWidget {
  final String title;
  final String subTitle;
  final String teacherUid;
  final String subjectId;
  final double classPrice;

  const AlertClass(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.teacherUid,
      required this.subjectId,
      required this.classPrice})
      : super(key: key);

  @override
  State<AlertClass> createState() => _AlertClass();
}

class _AlertClass extends State<AlertClass> {
  final user = FirebaseAuth.instance.currentUser!;
  String selectedHour = 'hh:mm';
  List<String> availableHours = ['hh:mm'];
  DateTime localDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<bool> availableDays = List.filled(7, true);
  String topics = "No se han especificado temas a ver";

  @override
  void initState() {
    _getTeacherAvailableHours();
    _getTeacherAvailableWeekdays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.subTitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("Fecha: "),
                TextButton(
                    child: Text(_getDate(selectedDate),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15.0)),
                    onPressed: () => _selectDate(context)),
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _selectDate(context),
                    iconSize: 20.0)
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text("Horario: "),
                  DropdownButton<String>(
                    menuMaxHeight: 200.0,
                    value: selectedHour,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedHour = newValue!;
                      });
                    },
                    items: availableHours
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("topics: "),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: TextField(
                    onChanged: (value) {
                      topics = value;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Temas a ver    ',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(MyColors.defaultColor)),
        ),
        ElevatedButton(
          onPressed: () => _handleBookedClass(
              context, widget.teacherUid, widget.subjectId, widget.classPrice),
          child: const Text('Reservar'),
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
            selectedHour = availableHours[0];
          })
        });
  }

  void _getTeacherAvailableWeekdays() async {
    var document = FirebaseFirestore.instance
        .collection(TeachersKeys.collectionName)
        .doc(widget.teacherUid);

    await document.get().then((document) => {
          setState(() {
            List<dynamic> firebaseAvailableDays =
                document[TeachersKeys.availableDays];

            availableDays = firebaseAvailableDays.cast<bool>();

            //print("AVAILABLE DAYS" + availableDays.toString());
            _setValidFirstDate();
          })
        });
  }

  void _setValidFirstDate() {
    if (_selectableDate(selectedDate)) {
      return;
    }

    bool foundAvailableDay = false;
    int i;
    for (i = 0; i < 7; ++i) {
      if (availableDays[(selectedDate.weekday + i) % 7]) {
        foundAvailableDay = true;
        break;
      }
    }
    //FIXME: Manejar de otra forma el hecho de que un profesor
    // no tenga fechas disponibles
    if (!foundAvailableDay) {
      print("Este profesor no tiene fechas disponibles");
      return;
    }
    selectedDate = selectedDate.add(Duration(days: i));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101),
        selectableDayPredicate: _selectableDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool _selectableDate(DateTime dt) {
    return availableDays[dt.weekday % 7];
  }

  String _getDate(DateTime dateTime) {
    return dateTime.toLocal().toString().split(' ')[0];
  }

  String _getTime(String time) {
    return time.split(':')[0];
  }

  void _handleBookedClass(BuildContext context, String teacherUid,
      String subjectId, double classPrice) async {
    bool classExists = false;
    String classDate = _getDate(selectedDate);
    String classTime = _getTime(selectedHour);
    String classDateTimeFormat = classDate + "_" + classTime;

    FirebaseFirestore store = FirebaseFirestore.instance;
    await store
        .collection(TeachersKeys.collectionName)
        .doc(teacherUid)
        .collection(ClassesKeys.collectionName)
        .doc(classDateTimeFormat)
        .get()
        .then((doc) {
      classExists = doc.exists;
    });

    if (classExists) {
      _showToast(context,
          "Este profesor ya tiene una clase ene este horario. Por favor, selecciona otro");
      return;
    }

    Navigator.pop(context, true);
    _updateClassesCollection(teacherUid, subjectId, classPrice);
  }

  void _updateClassesCollection(
      String teacherUid, String subjectId, double classPrice) async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    String classDate = _getDate(selectedDate);
    String classTime = _getTime(selectedHour);

    String classDateTimeFormat = classDate + "_" + classTime;

    try {
      await store
          .collection(StudentsKeys.collectionName)
          .doc(user.uid)
          .collection(ClassesKeys.collectionName)
          .doc(classDateTimeFormat)
          .set({
        ClassesKeys.teacherUid: teacherUid,
        ClassesKeys.date: classDate,
        ClassesKeys.time: classTime,
        ClassesKeys.subjectId: subjectId,
        ClassesKeys.cost: classPrice,
        ClassesKeys.topics: topics
      });

      await store
          .collection(TeachersKeys.collectionName)
          .doc(teacherUid)
          .collection(ClassesKeys.collectionName)
          .doc(classDateTimeFormat)
          .set({
        ClassesKeys.studentUid: user.uid,
        ClassesKeys.date: classDate,
        ClassesKeys.time: classTime,
        ClassesKeys.subjectId: subjectId,
        ClassesKeys.cost: classPrice,
        ClassesKeys.topics: topics
      });
    } on Exception catch (e) {
      /* print("MALARDOOOO"); */
      print(e);
    }
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
