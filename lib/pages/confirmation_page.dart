import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import '../widgets/other/tm_navigator.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPage();
}

class _ConfirmationPage extends State<ConfirmationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Confirma la clase',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            )),
        backgroundColor: MyColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          child: Column (
            children: [
              const SizedBox(height: 60),
              ElevatedButton(
                child: const Text(
                'Confirmar clase',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: MyColors.bottomNavBarBackground,
                    shadowColor: MyColors.black,
                    elevation: 10,
                    fixedSize: const Size(200, 200),
                    shape: const CircleBorder()

                )
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text('Danos tu feedback:',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                children: const <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MyColors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Cuéntanos cómo fue la clase...',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ]
            ),
          ),
        ),
      );
  }
}