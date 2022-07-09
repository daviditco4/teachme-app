import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teachme_app/widgets/viewClass/details_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Search',
      home: ConfirmClass(user: 'User'),
    );
  }
}

class ConfirmClass extends StatefulWidget {

  const ConfirmClass(
      {Key? key,
        required this.user})
      : super(key: key);
  final String user;

  @override
  State<ConfirmClass> createState() => _ConfirmClass();
}

class _ConfirmClass extends State<ConfirmClass> {
  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {return Center(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(18.0)),),
      child:Container(
        color: MyColors.cardClass,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text(widget.user + ' comentanos como fue la clase',
                style: const TextStyle(
                    color: MyColors.black,
                    fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  25, 10, 40, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Comentanos como fue la clase',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
              child: Row(
                children: <Widget>[
                Text('Califica la clase: '),
                RatingBar.builder(
                  itemSize: 25,
                  minRating: 1,
                  direction:
                  Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding:
                  const EdgeInsets
                      .symmetric(
                      horizontal:
                      2.0),
                  itemBuilder:
                      (context, _) =>
                  const Icon(
                    Icons.star,
                    color: MyColors.white,
                  ),
                  onRatingUpdate:
                      (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            ),
            SizedBox(height:10),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => viewDetails(context),
                  //onPressed: () => onPressed(widget.textButton),
                  child: Text('Confirmar Clase',
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


}

void viewDetails(BuildContext context) async {
  showDialog<bool>(context: context, builder: (context) => DetailsClass());
}

