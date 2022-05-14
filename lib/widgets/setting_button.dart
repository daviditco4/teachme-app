import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
              onPressed: () => onPressed(text),
              child: Text(text,
                  style: const TextStyle(
                    color: MyColors.text,
                    fontSize: 20,
                  )),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  backgroundColor:
                      MaterialStateProperty.all(MyColors.settingButton),
                  alignment: AlignmentDirectional.centerStart,
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20)),
                  fixedSize:
                      MaterialStateProperty.all(const Size.fromHeight(50)))),
          const SizedBox(height: 15)
        ]);
  }
}

void onPressed(String text) {
  print('Se presiono "$text"');
}
