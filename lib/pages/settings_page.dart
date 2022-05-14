import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/setting_button.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/teacher_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        bottomNavigationBar: const TMBottomNavigationBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 40),
                    child: Text("Configuración",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  SettingButton(text: 'Datos de Perfil'),
                  SettingButton(text: 'Privacidad'),
                  SettingButton(
                      text: 'Notificaciones',
                      onPressedPage: NotificationsPage()),
                  SettingButton(text: 'Métodos de Pago'),
                  SettingButton(text: 'Ayuda'),
                  SettingButton(text: 'Cerrar Sesión')
                ],
              ),
            ),
          ),
        ));
  }
}
