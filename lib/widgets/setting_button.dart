import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

PageRouteBuilder _noAnimationRouter(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation1, animation2) => page,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

class SettingButton extends StatelessWidget {
  const SettingButton({Key? key, required this.text, this.onPressedPage})
      : super(key: key);
  final String text;
  final Widget? onPressedPage;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
              onPressed: () {
                if (onPressedPage != null) {
                  Navigator.pushReplacement(
                      context, _noAnimationRouter(onPressedPage!));
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
