import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teachme_app/helpers/SubjectsKeys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';


class SearchTeacherSystem {

  //var firestore;
  // var subjectsCollec;
  // var teachersCollec;

  SearchTeacherSystem() {
    // firestore = FirebaseFirestore.instance;
    // subjectsCollec = firestore.collection("subjects");
    // teachersCollec = firestore.collection(TeachersKeys.collectionName);
  }

  Future<List<Map<String, dynamic>>> getTeachersBySubject(String subjectID) async {
    //Lista de teachers que dan la materia.
    List<Map<String, dynamic>> toReturn = [];

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
          toReturn.add(teacher as Map<String, dynamic>);
        }
      }
    } on Exception catch (e) {
      print("Exception in [SEARCH_TEACHER_SYSTEM] " + e.toString());
    }
    return toReturn;
  }


}