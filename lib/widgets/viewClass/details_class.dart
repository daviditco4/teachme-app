import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/main.dart';
import '../../constants/theme.dart';

class DetailsClass extends StatefulWidget {
  final String subject;
  final double cost;
  final String time;
  final String address;
  final String topics;
  final String otherUserName;

  const DetailsClass(
      {Key? key,
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
          height: 400,
          width: 300,
          color: MyColors.cardClass,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("\$${widget.cost}", style: const TextStyle(fontSize: 18))
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Horario',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.time, style: const TextStyle(fontSize: 18))
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Direccion',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.address, style: const TextStyle(fontSize: 18))
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text('Temario',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.topics, style: const TextStyle(fontSize: 17)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar Clase'),
                    style: MyColors.buttonStyleDefault,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cerrar'),
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

  ImageProvider _getUserImage() {
    String? userImageUrl = firebaseAuth.currentUser!.photoURL;
    if (userImageUrl != null) {
      return NetworkImage(userImageUrl);
    } else {
      return const AssetImage("assets/images/hasbulla.png");
    }
  }
}
