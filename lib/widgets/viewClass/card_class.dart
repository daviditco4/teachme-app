import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/widgets/viewClass/details_class.dart';

class CardClass extends StatefulWidget {
  final String title;
  final String textButton;
  final String schedule;
  final String address;
  final double cost;
  final String time;
  final String topics;
  final String otherUserName;
  final String subject;

  const CardClass(
      {Key? key,
      required this.title,
      required this.textButton,
      required this.schedule,
      required this.address,
      required this.cost,
      required this.time,
      required this.topics,
      required this.otherUserName,
      required this.subject})
      : super(key: key);

  @override
  State<CardClass> createState() => _CardClass();
}

class _CardClass extends State<CardClass> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        child: Container(
          color: MyColors.cardClass,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text(
                  widget.title,
                  style: const TextStyle(
                      color: MyColors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.schedule,
                    style: const TextStyle(
                      color: MyColors.black,
                      fontSize: 17,
                    )),
                trailing: CircleAvatar(
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
                        style: const TextStyle(
                            color: MyColors.white, fontSize: 15)),
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

  void onPressed(String text) {
    print('Se presiono "$text"');
  }

  void viewDetails(BuildContext context) async {
    showDialog<bool>(
        context: context,
        builder: (context) => DetailsClass(
              address: widget.address,
              cost: widget.cost,
              otherUserName: widget.otherUserName,
              subject: widget.subject,
              time: widget.time,
              topics: widget.topics,
            ));
  }
}
