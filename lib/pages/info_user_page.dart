import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/other/tm_navigator.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  State<InfoUser> createState() => _InfoUser();
}

class _InfoUser extends State<InfoUser> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Seguro quiere realizar los cambios?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Si'))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Buttom');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: MyColors.background,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () =>
                  TMNavigator.navigateToPage(context, const SettingsPage())),
          title: const Text('Datos del usuario',
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
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                      hintText: 'Escribir el nuevo email',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Usuario",
                      hintText: 'Escribir el nuevo usuario',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: ElevatedButton(
                    onPressed: () => showWarning(context),
                    child: const Text('Cambiar los datos'),
                    style: MyColors.buttonStyleDefault,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getUserEmail() {
    String? userEmail = firebaseAuth.currentUser!.email;
    return userEmail ?? "";
  }

  String _getUsername() {
    String? username = firebaseAuth.currentUser!.displayName;
    return username ?? "";
  }
}
