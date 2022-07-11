import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/main.dart';
import 'package:teachme_app/widgets/auth/profile_service.dart';
import '../../constants/theme.dart';

class DetailsClass extends StatefulWidget {
  final String cid;
  final String subject;
  final double cost;
  final String time;
  final String address;
  final String topics;
  final String otherUserName;

  const DetailsClass(
      {Key? key,
      required this.cid,
      required this.subject,
      required this.cost,
      required this.time,
      required this.address,
      required this.topics,
      required this.otherUserName})
      : super(key: key);
  @override
  _DetailsClass createState() => _DetailsClass();
}

class _DetailsClass extends State<DetailsClass> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 400,
          width: 320,
          color: MyColors.cardClass,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                CircleAvatar(
                  backgroundColor: MyColors.white,
                  backgroundImage: _getUserImage(),
                  radius: 45.0,
                ),
                Align(
                  child: Text(widget.subject,
                      style: const TextStyle(
                          color: MyColors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        userProfileType.value == ProfileType.student
                            ? 'Profesor'
                            : 'Alumno',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.otherUserName, style: TextStyle(fontSize: 18))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Precio',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("\$${widget.cost}",
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Horario',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.time, style: const TextStyle(fontSize: 18))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Direccion',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.address, style: const TextStyle(fontSize: 18))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text('Temario',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.topics, style: const TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _cancelarClase();
                      },
                      child: const Text('Cancelar Clase'),
                      style: MyColors.buttonStyleDefault,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cerrar'),
                      style: MyColors.buttonStyleDefault,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _getUserImage() {
    String? userImageUrl = firebaseAuth.currentUser!.photoURL;
    if (userImageUrl != null) {
      return NetworkImage(userImageUrl);
    } else {
      return const AssetImage("assets/images/hasbulla.png");
    }
  }

  void _cancelarClase() async {
    final studentid = FirebaseAuth.instance.currentUser!.uid;

    var classDoc = await FirebaseFirestore.instance
        .collection("students/$studentid/classes")
        .doc(widget.cid)
        .get();

    var data = classDoc.data();
    if (data != null && data.containsKey("teacherUid")) {
      var teacherid = data["teacherUid"].toString();

      FirebaseFirestore.instance
          .collection("students/$studentid/classes")
          .doc(widget.cid)
          .delete()
          .then(
              (value) => {
                    print("Document from teacher [class ${widget.cid}] deleted")
                  },
              onError: (e) => {print("Error updating document $e")});
      FirebaseFirestore.instance
          .collection("teachers/$teacherid/classes")
          .doc(widget.cid)
          .delete()
          .then(
              (value) => {
                    print("Document from teacher [class ${widget.cid}] deleted")
                  },
              onError: (e) => {print("Error updating document $e")});
    }
  }
}
