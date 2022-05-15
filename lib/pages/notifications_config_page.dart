import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

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
          RaisedButton(
              padding: EdgeInsets.all(15),
              color: Colors.red,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Acepto todo", style: TextStyle(fontSize: 20),),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              onPressed: ()=>{
                Navigator.pop(context)
              })
          ],
        ),
    );
  }
}
