import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/widgets/viewClass/details_class.dart';

class CardClass extends StatefulWidget {

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
  State<CardClass> createState() => _CardClass();
}

class _CardClass extends State<CardClass> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {return Center(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),),
      child:Container(
        color: MyColors.cardClass,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(widget.title,
              style: const TextStyle(
                color: MyColors.black,
                fontSize: 17),
            ),
            subtitle: Text(
                widget.schedule,
                style: const TextStyle(
                  color: MyColors.black,
                  fontSize: 17,
                )),
            trailing:  CircleAvatar(
                    backgroundColor: MyColors.white,
                    backgroundImage: _getUserImage(),
                    radius: 65.0,
                    // maxRadius: 200.0,
                  ),
          ),

        Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => viewDetails(context),
              //onPressed: () => onPressed(widget.textButton),
              child: Text(widget.textButton,
                  style: const TextStyle(color: MyColors.white, fontSize: 15)),
              style: MyColors.buttonStyleDefault,
            ),
          ],
        ),
      ],
      ),
    ),
    ),
    );
  }

  ImageProvider _getUserImage() {
    String? userImageUrl = firebaseAuth.currentUser!.photoURL;
    if (userImageUrl != null) {
      return NetworkImage(userImageUrl);
    } else {
      return const AssetImage("assets/images/hasbulla.png");
    }
  }
}

void onPressed(String text) {
  print('Se presiono "$text"');
}

void viewDetails(BuildContext context) async {
  showDialog<bool>(context: context, builder: (context) => DetailsClass());
}

