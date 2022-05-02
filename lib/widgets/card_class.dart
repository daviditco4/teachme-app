import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

class CardClass extends StatelessWidget {
  const CardClass(
      {Key? key,
      required this.title,
      required this.textButton,
      required this.schedule,
      required this.direction})
      : super(key: key);
  final String title;
  final String textButton;
  final String schedule;
  final String direction;

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Card(
    child:Container(
        color: MyColors.cardClass,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        TextButton(
        onPressed: () => onPressed(title),
        child: Text(title,
        style: const TextStyle(
        color: MyColors.white,
        fontSize: 15,
        )),
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.cardClass),
        alignment: AlignmentDirectional.centerStart,
        padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 20)),
        fixedSize:
        MaterialStateProperty.all(const Size.fromHeight(75))
        ),
        ),
            Text(schedule,
                style: const TextStyle(
                  color: MyColors.white,
                  fontSize: 15,
                )),
          Text(direction,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 15,
              )),
      Row(
        children: <Widget>[
        TextButton(
        onPressed: () => onPressed(textButton),

        child: Text(textButton,
        style: const TextStyle(
        color: MyColors.white,
        fontSize: 12,
        )),
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass),
        ),
        ),
        ],
        ),
      ],
      ),
    ),
    ),
    );
  }
}

void onPressed(String text) {
  print('Se presiono "$text"');
}
