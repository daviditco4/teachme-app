import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/constants/theme.dart';
import '../../constants/theme.dart';

class DetailsClass extends StatefulWidget {
  const DetailsClass({Key? key}) : super(key: key);
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
          height: 400,
          width: 300,
          color: MyColors.cardClass,
          child: Column(children: [
              const SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: MyColors.white,
              backgroundImage: _getUserImage(),
              radius: 45.0,
            ),
              Align(
                child: Text('Materia',
                    style: const TextStyle(
                        color: MyColors.black,
                        fontSize: 28.0, fontWeight: FontWeight.bold)),
              ),
            SizedBox(height:20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Profesor', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Nombre', style: const TextStyle(fontSize: 18))
              ],
            ),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text('Precio', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('950', style: const TextStyle(fontSize: 18))
              ],
            ),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Horario', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('08:00', style: const TextStyle(fontSize: 18))
              ],
            ),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Direccion', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Calle falsa 123', style: const TextStyle(fontSize: 18))
              ],
            ),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Temario', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Temas a ver en la clase', style: const TextStyle(fontSize: 17)),
              ],
            ),
            SizedBox(height:20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancelar Clase'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: const BorderSide(color: Colors.white)))),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cerrar'),
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(color: Colors.white)))),
                ),
              ],
            ),
            ],
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
}