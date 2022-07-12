import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/widgets/confirmclass.dart';
import 'package:teachme_app/widgets/other/tm_navigator.dart';

class TMNotification extends StatefulWidget {
  final String username;
  final String uid;
  final String classDocName;
  final String imgUrl;
  final String timeAgo;

  const TMNotification(
      {Key? key,
      required this.username,
      required this.imgUrl,
      required this.timeAgo,
      required this.uid,
      required this.classDocName})
      : super(key: key);

  @override
  State<TMNotification> createState() => _TMNotification();
}

class _TMNotification extends State<TMNotification> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(foregroundImage: NetworkImage(widget.imgUrl)),
        title: RichText(
            text: TextSpan(
                text: '¿Cómo estuvo tu clase con ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
              TextSpan(
                  text: widget.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.highlightText)),
              const TextSpan(
                  text: ' ? No te olvides de confirmar la finalización')
            ])),
        subtitle: Text("Hace ${widget.timeAgo} hora(s)"),
        onTap: () => showDialog<bool>(
              context: context,
              builder: (context) => ConfirmClassCard(
                  otherUserName: widget.username,
                  otherUserUID: widget.uid,
                  classDocName: widget.classDocName),
            ));
  }
}
