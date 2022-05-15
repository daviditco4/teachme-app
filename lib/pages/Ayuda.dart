import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Ayuda extends StatefulWidget {
  const Ayuda({Key? key}) : super(key: key);

  @override
  State<Ayuda> createState() => _Ayuda();
}

class _Ayuda extends State<Ayuda> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Seguro quiere reportar el mensaje?'),
      actions: [
        ElevatedButton(onPressed:() => Navigator.pop(context, false), child: Text('No')),
        ElevatedButton(onPressed:() => Navigator.pop(context, true), child: Text('Si'))
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => navigateTo(context, const SettingsPage())
          ),
          title: const Text('Ayuda',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
          backgroundColor: MyColors.background,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: Text('Reportar un problema'),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: Text('Solicitudes de ayuda'),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: Text('Ayuda sobre privacidad y seguridad'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

}