import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/Ayuda.dart';
import 'package:teachme_app/pages/payment_methods_page.dart';
import 'package:teachme_app/pages/profile_page.dart';
import 'package:teachme_app/widgets/bottom_nav_bar.dart';
import 'package:teachme_app/widgets/setting_button.dart';
import 'package:teachme_app/pages/notifications_page.dart';
import 'package:teachme_app/pages/info_user_page.dart';
import 'package:teachme_app/pages/notifications_config_page.dart';

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
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: (){}
          ),
          title: const Text('Configuración',
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  SettingButton(
                      text: 'Datos de Perfil',
                      onPressedPage: InfoUser()),
                  SettingButton(text: 'Privacidad'),
                  SettingButton(
                      text: 'Notificaciones',
                      onPressedPage: NotificationConfig()),
                  SettingButton(
                      text: 'Metodos de pago',
                      onPressedPage: PaymentMethod()),
                  SettingButton(text: 'Ayuda',
                      onPressedPage: Ayuda()),
                  SettingButton(text: 'Cerrar Sesión')
                ],
              ),
            ),
          ),
        ));
  }
}
