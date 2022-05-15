import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'other/tm_navigator.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {Key? key,
      required this.text,
      this.onPressedPage,
      this.onPressedFunction})
      : super(key: key);
  final String text;
  final Widget? onPressedPage;
  final Function? onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
              onPressed: () {
                if (onPressedPage != null) {
                  TMNavigator.navigateTo(context, onPressedPage!);
                } else if (onPressedFunction != null) {
                  onPressedFunction!;
                } else {
                  onPressed(text);
                }
              },
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
