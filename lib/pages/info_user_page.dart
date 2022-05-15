import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

import 'package:flutter/material.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  State<InfoUser> createState() => _InfoUser();
}

class _InfoUser extends State<InfoUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 40),
                  child: Text("Datos del perfil",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                ],
              ),
            ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Dejar mail existente',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Dejar el user existente',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '********',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130.0),
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('Cambios los datos'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          MyColors.buttonCardClass),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: const BorderSide(
                                  color: Colors.white)))
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}