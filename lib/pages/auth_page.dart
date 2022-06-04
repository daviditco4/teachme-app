import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path show extension;
import 'package:teachme_app/helpers/students_keys.dart';

import '../helpers/snack_bars.dart';
import '../helpers/teachers_keys.dart';
import '../widgets/auth/auth_form.dart' show AuthForm;

const studentsCollectionPath = 'students';
const teachersCollectionPath = 'teachers';
const student = 0;
const teacher = 1;

class AuthPage extends StatelessWidget {
  Future<bool> _authenticate({
    required BuildContext context,
    File? userImage,
    required Map<String, String> authData,
    bool signup = false,
  }) async {
    try {
      if (signup) {
        userImage!;

        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authData['email']!,
          password: authData['password']!,
        );
        final user = res.user!;

        final imageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(user.uid + path.extension(userImage.path));
        await imageRef.putFile(userImage);
        final imageURL = await imageRef.getDownloadURL();

        await user.updateDisplayName(authData['username']!);
        await user.updatePhotoURL(imageURL);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authData['email']!,
          password: authData['password']!,
        );
      }
      return true;
    } on FirebaseException catch (e) {
      SnackBars.showError(context: context, message: e.message);
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print("[AUTH_PAGE 54]: Current user ${FirebaseAuth.instance.currentUser}");
    const verticalSpace = SizedBox(height: 18.0);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
          child: Container(
            color: const Color(0xFFE6FFFF),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Scaffold(
                    backgroundColor: const Color(0xFFE6FFFF),
                    body: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Card(
                              //margin: const EdgeInsets.all(5.0),
                              child: Container(
                                color: const Color.fromARGB(255, 230, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AuthForm(_authenticate),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /* Crea una entrada en la tabla de teachers o students, segun corresponda */
  void _updateUsersTable() async {
    /*TODO: Switch entre alumno y profesor */
    try {
      final user = FirebaseAuth.instance.currentUser!;
      const int userCategory = 0;
      const String userCategoryPath = studentsCollectionPath;

      if (userCategory == student) {
        await FirebaseFirestore.instance.collection(userCategoryPath).add({
          StudentsKeys.name: user.displayName,
          StudentsKeys.photoUrl: user.photoURL,
          StudentsKeys.uid: user.uid,
          /* TODO: 
          StudentsKeys.uid: user.address*/
        });
      } else {
        await FirebaseFirestore.instance.collection(userCategoryPath).add({
          TeachersKeys.name: user.displayName,
          TeachersKeys.photoUrl: user.photoURL,
          TeachersKeys.uid: user.uid
          /* TODO: 
           * StudentsKeys.uid: user.address
          */
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
