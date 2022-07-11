import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //String _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
    child:
    Container(
        color: const Color(0xFFE6FFFF),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Image(
                      image: AssetImage("assets/images/teach_me_logo.png"),
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 1,
                    child: Text('Inicia sesión',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Poppins')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scaffold(
                backgroundColor: const Color(0xFFE6FFFF),
                body: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text('Usuario',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Poppins')),
                        ],
                      ),
                      TextFormField(
                          controller: _userController,
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              hintText: 'Ingresar usuario'),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Poppins')),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text('Contraseña',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Poppins')),
                        ],
                      ),
                      TextFormField(
                          controller: _passwordController,
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: '[Some hint text...]',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Poppins')),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            '¿Ha olvidado su contraseña?',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        child: const Text('Inicia sesión'),
                        onPressed: () {
                          print("Usuario: " + _userController.text);
                          print("Contraseña: " + _passwordController.text);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF002A7F)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side: const BorderSide(
                                        color: Colors.white)))),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    ),
      ),
    );
  }
}
