import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/widgets/viewClass/details_class.dart';

class CardClass extends StatefulWidget {
  final String cid;
  final String title;
  final String textButton;
  final String schedule;
  final String address;
  final double cost;
  final String time;
  final String topics;
  final String otherUserName;
  final String otherUserImage;
  final String subject;

  const CardClass(
      {Key? key,
      required this.cid,
      required this.title,
      required this.textButton,
      required this.schedule,
      required this.address,
      required this.cost,
      required this.time,
      required this.topics,
      required this.otherUserName,
      required this.otherUserImage,
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => viewDetails(context),
                    child: Text(widget.textButton,
                        style: const TextStyle(
                            color: MyColors.white, fontSize: 15)
                    ),
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
    String? userImageUrl = widget.otherUserImage;
    return NetworkImage(userImageUrl);
  }

  void onPressed(String text) {
    print('Se presiono "$text"');
  }

  void viewDetails(BuildContext context) async {
    showDialog<bool>(
        context: context,
        builder: (context) => DetailsClass(
              cid: widget.cid,
              address: widget.address,
              cost: widget.cost,
              otherUserName: widget.otherUserName,
              otherUserImage: widget.otherUserImage,
              subject: widget.subject,
              time: widget.time,
              topics: widget.topics,
            ));
  }
}
