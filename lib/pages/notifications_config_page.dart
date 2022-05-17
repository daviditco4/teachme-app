import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';

import '../widgets/bottom_nav_bar.dart';

/*
class NotificationConfig extends StatelessWidget {
  const NotificationConfig({Key? key}) : super(key: key);

  static const String _title = 'Notificaciones';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}
*/
class NotificationConfig extends StatefulWidget {
  const NotificationConfig({Key? key}) : super(key: key);

  @override
  State<NotificationConfig> createState() => _NotificationConfig();
}

class _NotificationConfig extends State<NotificationConfig> {
  bool _mensajes = true;
  bool _recordatorio = true;
  bool _proxClase = true;
  bool _pagos = true;

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
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 40),
                  child: Text("Notificaciones",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),

                ),
              ],
            ),
          ),
          SwitchListTile(
              title: const Text('Mensajes'),
              value: _mensajes,
              onChanged: (bool value) {
                setState(() {
                  _mensajes = value;
                });
              },
            ),

          SwitchListTile(
            title: const Text('Recordatorios'),
            value: _recordatorio,
            onChanged: (bool value) {
              setState(() {
                _recordatorio= value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Proxima clase'),
            value: _proxClase,
            onChanged: (bool value) {
              setState(() {
                _proxClase= value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Recordatorios de pagos'),
            value: _pagos,
            onChanged: (bool value) {
              setState(() {
                _pagos= value;
              });
            },
          ),
          ],
        ),
    );
  }
}
