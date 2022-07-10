import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teachme_app/helpers/subject_keys.dart';
import 'package:teachme_app/helpers/geolocation_helper.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/widgets/auth/profile_service.dart';

class SearchTeacherSystem {
  //var firestore;
  // var subjectsCollec;
  // var teachersCollec;

  SearchTeacherSystem() {
    // firestore = FirebaseFirestore.instance;
    // subjectsCollec = firestore.collection("subjects");
    // teachersCollec = firestore.collection(TeachersKeys.collectionName);
  }

  Future<List<Map<String, dynamic>>> getTeachersBySubject(
      String? subjectID) async {
    //teacherOnce hace referencia a si un profesor puede aparecer por cada matería que da o a lo sumo una única vez.
    //Lista de teachers que dan la materia.
    List<Map<String, dynamic>> toReturn = [];

    if (subjectID == null) {
      try {
        var querySnapshot = await FirebaseFirestore.instance
            .collection(SubjectsKeys.collectionName)
            .get();

        Set<String> inSet = {};
        var docIterator = querySnapshot.docs.iterator;
        while (docIterator.moveNext()) {
          var currentSubject = docIterator.current.data();

          for (String teacherID in currentSubject[SubjectsKeys.teachers]) {
            inSet.add(teacherID);
          }
        }

        for (String teacherID in inSet) {
          var teacher = await FirebaseFirestore.instance
              .collection(TeachersKeys.collectionName)
              .doc(teacherID)
              .get();
          var teacherMap = teacher.data();
          if (teacherMap != null) {
            toReturn.add(teacherMap);
          }
        }
      } on Exception catch (e) {
        print("Exception in [SEARCH_TEACHER_SYSTEM] " + e.toString());
      }
    } else {
      try {
        var doc = await FirebaseFirestore.instance
            .collection(SubjectsKeys.collectionName)
            .doc(subjectID)
            .get();

        if (doc.exists) {
          Map<String, dynamic> data = doc.data()!;

          for (String teacherID in data[SubjectsKeys.teachers]) {
            var teacher = await FirebaseFirestore.instance
                .collection(TeachersKeys.collectionName)
                .doc(teacherID)
                .get();
            var teacherMap = teacher.data();
            if (teacherMap != null) {
              toReturn.add(teacherMap);
            }
          }
        }
      } on Exception catch (e) {
        print("Exception in [SEARCH_TEACHER_SYSTEM] " + e.toString());
      }
    }
    return _orderByDistance(toReturn);
  }

  /* Debe ser necesariamente un estudiante quien llame a este método */
  Future<List<Map<String, dynamic>>> _orderByDistance(
      List<Map<String, dynamic>> inList) async {
    var userProfile = await ProfileService().getProfile();
    if (userProfile != null) {
      var userLat = double.parse(userProfile[StudentsKeys.positionLatitude]);
      var userLon = double.parse(userProfile[StudentsKeys.positionLongitude]);

      for (Map<String, dynamic> currentTeacher in inList) {
        if (currentTeacher[TeachersKeys.positionLatitude].isEmpty ||
            currentTeacher[TeachersKeys.positionLongitude].isEmpty) {
          currentTeacher["distance"] = -1;
        }

        currentTeacher["distance"] = GeolocationHelper()
            .calculateDistance(
                userLat,
                userLon,
                double.parse(currentTeacher[StudentsKeys.positionLatitude]),
                double.parse(currentTeacher[StudentsKeys.positionLongitude]))
            .ceil();
      }
    }
    return inList;
  }
}

/*
      inList.sort((a, b) => GeolocationHelper()
          .calculateDistance(userLat, userLon, b[StudentsKeys.positionLatitude],
              b[StudentsKeys.positionLatitude])
          .compareTo(GeolocationHelper().calculateDistance(
              userLat,
              userLon,
              a[StudentsKeys.positionLatitude],
              a[StudentsKeys.positionLongitude])));
    */