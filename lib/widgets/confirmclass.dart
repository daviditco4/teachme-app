import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/helpers/classes_keys.dart';
import 'package:teachme_app/helpers/students_keys.dart';
import 'package:teachme_app/helpers/teachers_keys.dart';
import 'package:teachme_app/main.dart';
import 'package:teachme_app/widgets/viewClass/details_class.dart';

class ConfirmClassCard extends StatefulWidget {
  final String otherUserName;
  final String otherUserUID;
  final String classDocName;

  const ConfirmClassCard(
      {Key? key,
      required this.otherUserName,
      required this.otherUserUID,
      required this.classDocName})
      : super(key: key);

  @override
  State<ConfirmClassCard> createState() => _ConfirmClassCard();
}

class _ConfirmClassCard extends State<ConfirmClassCard> {
  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        child: Container(
          color: MyColors.cardClass,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text(
                  ' Considera escribir un comentario sobre tu clase con ${widget.otherUserName}',
                  style: const TextStyle(color: MyColors.black, fontSize: 17),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Comentanos como fue la clase',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                child: Row(
                  children: <Widget>[
                    const Text('Califica la clase: '),
                    RatingBar.builder(
                      itemSize: 25,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: MyColors.white,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text("Recuerda confirmar que se hizo la clase"),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _handleClassConfirmed(),
                    child: const Text('Confirmar',
                        style: TextStyle(color: MyColors.white, fontSize: 15)),
                    style: MyColors.buttonStyleDefault,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleClassConfirmed() async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    double rating = 3.5;
    String comment = "Este es un comentario de la clase";
    bool isStudent = userProfileType.value == ProfileType.student;
    String userCollectionPath =
        isStudent ? StudentsKeys.collectionName : TeachersKeys.collectionName;
    String otherUserCollectionPath =
        isStudent ? TeachersKeys.collectionName : StudentsKeys.collectionName;
    String userConfirmedField =
        isStudent ? ClassesKeys.studentConfirmed : ClassesKeys.teacherConfirmed;
    String otherUserConfirmedField =
        isStudent ? ClassesKeys.teacherConfirmed : ClassesKeys.studentConfirmed;

    // Agrego el comentario
    await store
        .collection(otherUserCollectionPath)
        .doc(widget.otherUserUID)
        .update({
      "comments": FieldValue.arrayUnion([comment]),
    });

    // Actualizo en las clases del usuario, que confirmo
    await store
        .collection(otherUserCollectionPath)
        .doc(widget.otherUserUID)
        .collection(ClassesKeys.collectionName)
        .doc(widget.classDocName)
        .update({userConfirmedField: true});

    // Actualizo en las clases del otro, que confirmo
    await store
        .collection(userCollectionPath)
        .doc(userUid)
        .collection(ClassesKeys.collectionName)
        .doc(widget.classDocName)
        .update({userConfirmedField: true});

    // Actualizo rating del profesor (si soy alumno)
    if (isStudent) {
      double newAccumRating = 0.0;
      int newReviewCount = 0;
      var otherUserDocument =
          store.collection(otherUserCollectionPath).doc(widget.otherUserUID);

      await otherUserDocument.get().then((doc) {
        newAccumRating = doc[TeachersKeys.accumRatig] + rating;
        newReviewCount = doc[TeachersKeys.reviewCount] + 1;
      });

      await otherUserDocument.update({
        TeachersKeys.accumRatig: newAccumRating,
        TeachersKeys.reviewCount: newReviewCount,
        TeachersKeys.rating: newAccumRating / newReviewCount.toDouble()
      });
    }

    Navigator.pop(context);
  }
}
