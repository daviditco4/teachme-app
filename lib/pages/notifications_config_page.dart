import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/other/tm_navigator.dart';

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
        backgroundColor: MyColors.background,
        title: const Text('Notificaciones',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () =>
                TMNavigator.navigateToPage(context, const SettingsPage())),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
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
                _recordatorio = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Proxima clase'),
            value: _proxClase,
            onChanged: (bool value) {
              setState(() {
                _proxClase = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Recordatorios de pagos'),
            value: _pagos,
            onChanged: (bool value) {
              setState(() {
                _pagos = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
