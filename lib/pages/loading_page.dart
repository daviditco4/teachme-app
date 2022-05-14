import 'dart:html';

import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/images/loading_background_opacity8.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 200,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/teach_me_logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const NiceButton(
                        text: "Regístrate ahora",
                        color: Color.fromARGB(255, 0, 42, 127),
                        internalFontSize: 24),
                    Row(
                      children: [
                        const Spacer(),
                        const Text("¿Ya tienes una cuenta?",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                        TextButton(
                          child: const Text("Inicia sesión",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        ),
                        const Spacer()
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class NiceButton extends StatelessWidget {
  const NiceButton({
    Key? key,
    required this.text,
    required this.color,
    required this.internalFontSize,
  }) : super(key: key);

  final String text;
  final Color color;
  final double internalFontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              32.0,
            ),
          ),
        ),
      ),
      onPressed: () {
        // Respond to button press
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: 10,
          bottom: 10,
        ),
        child: Text(text, style: TextStyle(fontSize: internalFontSize)),
      ),
    );
  }
}
