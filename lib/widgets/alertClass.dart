import 'package:flutter/material.dart';

import '../constants/Theme.dart';

class AlertClass extends StatefulWidget {
  final String title;
  final String subTitle;

  const AlertClass({Key? key, required String this.title, required String this.subTitle}) : super(key: key);

  @override
  State<AlertClass> createState() => _AlertClass();
}

class _AlertClass extends State<AlertClass>  {

  String dropdownValue = '12:30';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.zero,
      content: Row(
        children: <Widget>[
          Text(widget.subTitle),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['12:30', '13:30', '14:30', '15:30'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  MyColors.buttonCardClass)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Si'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
              MyColors.buttonCardClass)),
        ),
      ],
    );
  }
}
