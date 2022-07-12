import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/helpers/users_profile_type_keys.dart';
import 'package:teachme_app/widgets/auth/auth_service.dart';

class ProfileService {
  Future<Map<String, dynamic>?> getProfile(String userId) async {
    if (userId.isEmpty) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    }
    try {
      var docSnapShot = await FirebaseFirestore.instance
          .collection("usersProfileType")
          .doc(userId)
          .get();
      var userType = docSnapShot.get(UsersProfileTypeKeys.type);

      if (userType == "student") {
        var doc = await FirebaseFirestore.instance
            .collection(StudentsKeys.collectionName)
            .doc(userId)
            .get();
        return doc.data();
      } else {
        var doc = await FirebaseFirestore.instance
            .collection(TeachersKeys.collectionName)
            .doc(userId)
            .get();
        return doc.data();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  void updateDescription(String newDescription) async {
    //Primero nos fijamos si es estudiante o alumno
    try {
      final user = await AuthService().getCurrentUser();
      var docSnapShot = await FirebaseFirestore.instance
          .collection("usersProfileType")
          .doc(user?.uid)
          .get();
      var userType = docSnapShot.get(UsersProfileTypeKeys.type);

      if (userType == "student") {
        await FirebaseFirestore.instance
            .collection(StudentsKeys.collectionName)
            .doc(user?.uid)
            .update({StudentsKeys.description: newDescription});
      } else {
        await FirebaseFirestore.instance
            .collection(TeachersKeys.collectionName)
            .doc(user?.uid)
            .update({TeachersKeys.description: newDescription});
      }
    } on Exception catch (e) {
      print("[profile_service] " + e.toString());
    }
  }

  void updatePosition(Position newPosition) async {
    //Primero nos fijamos si es estudiante o alumno
    try {
      final user = await AuthService().getCurrentUser();
      var docSnapShot = await FirebaseFirestore.instance
          .collection("usersProfileType")
          .doc(user?.uid)
          .get();
      var userType = docSnapShot.get(UsersProfileTypeKeys.type);

      if (userType == "student") {
        await FirebaseFirestore.instance
            .collection(StudentsKeys.collectionName)
            .doc(user?.uid)
            .update({
          StudentsKeys.positionLatitude: newPosition.latitude.toString(),
          StudentsKeys.positionLongitude: newPosition.longitude.toString()
        });
      } else {
        await FirebaseFirestore.instance
            .collection(TeachersKeys.collectionName)
            .doc(user?.uid)
            .update({
          TeachersKeys.positionLatitude: newPosition.latitude.toString(),
          TeachersKeys.positionLongitude: newPosition.longitude.toString()
        });
      }
    } on Exception catch (e) {
      print("[profile_service] " + e.toString());
    }
  }
}
