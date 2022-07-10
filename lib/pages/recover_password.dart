import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecoverPassword extends StatefulWidget {
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  const RecoverPassword({Key? key}) : super(key: key);

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Enviada la petición para recuperar contrazeña de: " + _email!);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
          child: Container(
            color: const Color(0xFFE6FFFF),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Scaffold(
                    backgroundColor: const Color(0xFFE6FFFF),
                    body: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Card(
                              //margin: const EdgeInsets.all(5.0),
                              child: Container(
                                color: const Color.fromARGB(255, 230, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                              "assets/images/teach_me_logo.png"),
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.fill),
                                      const Text('Inicia sesión',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins')),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.next,
                                              validator: (value) {
                                                if (value != null &&
                                                    RecoverPassword._emailRegExp
                                                        .hasMatch(value)) {
                                                  return null;
                                                }
                                                return 'Enter a valid email address.';
                                              },
                                              onSaved: (email) =>
                                                  _email = email,
                                              decoration: const InputDecoration(
                                                icon: Icon(Icons.email),
                                                labelText: 'Email',
                                              ),
                                            ),
                                            ElevatedButton(
                                              child: const Text('Recuperar'),
                                              onPressed: _resetPassword,
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xFF002A7F)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          side: const BorderSide(
                                                              color: Colors
                                                                  .white)))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

/*

Column(mainAxisSize: MainAxisSize.min, children: const [
          Image(
              image: AssetImage("assets/images/teach_me_logo.png"),
              width: 200,
              height: 200,
              fit: BoxFit.fill),
          Text('Inicia sesión',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins')),
        ],
        ),

*/