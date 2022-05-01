import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

class TMNotification extends StatelessWidget {
  const TMNotification(
      {Key? key,
      required this.professorName,
      required this.professorImage,
      required this.timeAgo})
      : super(key: key);
  final String professorName;
  final ImageProvider professorImage;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(foregroundImage: professorImage),
        title: RichText(
            text: TextSpan(
                text: '¿Cómo estuvo tu clase con ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
              TextSpan(
                  text: professorName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.highlightText)),
              const TextSpan(text: ' ?')
            ])),
        subtitle: Text("Hace $timeAgo"));
  }
}
