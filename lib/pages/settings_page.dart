import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/widgets/main_drawer.dart';
import 'package:teachme_app/widgets/nav_bar.dart';
import 'package:teachme_app/widgets/setting_button.dart';

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
        //appBar: const Navbar(),
        //drawer: const MainDrawer(),
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
                  SettingButton(text: 'Notificaciones'),
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
