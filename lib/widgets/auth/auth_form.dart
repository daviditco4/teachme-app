import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:teachme_app/pages/recover_password.dart';

import '../../helpers/snack_bars.dart';
import '../../helpers/students_keys.dart';
import '../../helpers/teachers_keys.dart';
import '../../helpers/users_profile_type_keys.dart';
import 'auth_fields_column.dart';

enum AuthMode { signin, signup }

const studentsCollectionPath = 'students';
const teachersCollectionPath = 'teachers';
const usersProfileTypeCollectionPath = 'usersProfileType';
const student = 0;
const teacher = 1;

class AuthForm extends StatefulWidget {
  const AuthForm(this.onFormSubmitted);

  final Future<bool> Function({
    required BuildContext context,
    File? userImage,
    required Map<String, String> authData,
    bool signup,
  }) onFormSubmitted;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedUserImage;
  final _userInput = <String, String>{};
  var _authMode = AuthMode.signin;
  var _isLoading = false;
  var isKeyboardOpen = false;

  void _switchAuthMode() {
    setState(() {
      const signinMode = AuthMode.signin;
      _authMode = (_authMode == signinMode) ? AuthMode.signup : signinMode;
    });
  }

  void _submit() async {
    if (_authMode == AuthMode.signup && _pickedUserImage == null) {
      SnackBars.showError(context: context, message: 'Please pick a photo.');
      return;
    }

    final form = _formKey.currentState!;

    if (form.validate()) {
      form.save();
      setState(() => _isLoading = true);

      bool success;
      success = await widget.onFormSubmitted(
        context: context,
        userImage: _pickedUserImage,
        authData: _userInput,
        signup: _authMode == AuthMode.signup,
      );

      /* print("DATARDOS DEL USUARIO:");
      print(FirebaseAuth.instance.currentUser!.displayName);
      print(FirebaseAuth.instance.currentUser!.uid); */

      if (!success) {
        setState(() => _isLoading = false);
      } else {
        if (_userInput['type'] == null) {
          print("El tipo de cuenta es NULL");
        }
        _updateUsersProfileTypesCollection(_userInput['type']!);
        _updateStudentsOrTeachersCollection(_userInput['type']!);
      }
    }
  }

  /* FIXME: Cambiar esto al nuevo Navigator */
  PageRouteBuilder _noAnimationRouter(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  void _recoverAccount() {
    Navigator.pushReplacement(context, _noAnimationRouter(RecoverPassword()));
  }

  @override
  Widget build(BuildContext context) {
    final isSigninMode = (_authMode == AuthMode.signin);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedChildVisibleOnCondition(
                onInvisibleWidget: const SizedBox(height: 4.0),
                verticalSpace: SizedBox(height: 12.0),
                verticalSpaceLocation: VerticalDirection.down,
                condition: isSigninMode,
                child: _buildAnimatedChildVisibleOnCondition(
                    condition:
                        WidgetsBinding.instance?.window.viewInsets.bottom == 0,
                    onInvisibleWidget: const SizedBox(height: 6.0),
                    verticalSpaceLocation: VerticalDirection.down,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Image(
                            image:
                                AssetImage("assets/images/teach_me_logo.png"),
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill),
                        Text('Inicia sesión',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins')),
                      ],
                    ),
                    verticalSpace: SizedBox(height: 9))),
            AuthFieldsColumn(
              authMode: _authMode,
              onUserImageSaved: (newValue) => _pickedUserImage = newValue,
              onEmailSaved: (newValue) => _userInput['email'] = newValue!,
              onUsernameSaved: (newValue) => _userInput['username'] = newValue!,
              onPasswordSaved: (newValue) => _userInput['password'] = newValue!,
              onUserProfileTypeSaved: (newValue) =>
                  _userInput['type'] = newValue!,
              currentUserImage: _pickedUserImage,
              enabled: !_isLoading,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 12.0),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                child: SizedBox(child: LinearProgressIndicator()),
              )
            else
              Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        child: const Text(
                          '¿Ha olvidado su contraseña?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: _recoverAccount,
                      ),
                      const Spacer(),
                      TextButton(
                        child:
                            /* TODO: Traducir esta linea */
                            Text('Sign ${isSigninMode ? 'Up' : 'In'} Instead'),
                        onPressed: _switchAuthMode,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text(isSigninMode ? 'INGRESAR' : 'REGISTRARSE'),
                    onPressed: _submit,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF002A7F)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(color: Colors.white)))),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAnimatedChildVisibleOnCondition({
  required bool condition,
  required Widget child,
  SizedBox? onInvisibleWidget,
  required SizedBox verticalSpace,
  VerticalDirection verticalSpaceLocation = VerticalDirection.up,
}) {
  final hasTopSpace = (verticalSpaceLocation == VerticalDirection.up);

  return AnimatedCrossFade(
    duration: const Duration(milliseconds: 500),
    sizeCurve: Curves.ease,
    alignment: hasTopSpace ? Alignment.bottomCenter : Alignment.topCenter,
    crossFadeState:
        condition ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    firstChild: onInvisibleWidget ?? Container(),
    secondChild: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasTopSpace) verticalSpace,
        if (condition) child,
        if (!hasTopSpace) verticalSpace,
      ],
    ),
  );
}

/* Crea una entrada en la tabla de teachers o students, segun corresponda */
void _updateStudentsOrTeachersCollection(String userType) async {
  /*TODO: Switch entre alumno y profesor */
  try {
    final user = FirebaseAuth.instance.currentUser!;
    /* print(" DATOS DEL USUARIO 2");
    print(user); */
    final String userCategoryPath =
        userType == 'student' ? studentsCollectionPath : teachersCollectionPath;

    if (userType == student) {
      await FirebaseFirestore.instance.collection(userCategoryPath).add({
        StudentsKeys.name: user.displayName,
        StudentsKeys.photoUrl: user.photoURL,
        StudentsKeys.uid: user.uid,
        StudentsKeys.address: 'placeholder'
      });
    } else {
      await FirebaseFirestore.instance.collection(userCategoryPath).add({
        TeachersKeys.name: user.displayName,
        TeachersKeys.photoUrl: user.photoURL,
        TeachersKeys.uid: user.uid,
        TeachersKeys.address: 'placeholder'
      });
    }
  } on Exception catch (e) {
    /* print("MALARDOOOO 2"); */
    print(e);
  }
}

void _updateUsersProfileTypesCollection(String userType) async {
  try {
    final user = FirebaseAuth.instance.currentUser!;
    /* print(" DATOS DEL USUARIO");
    print(user); */
    await FirebaseFirestore.instance
        .collection(usersProfileTypeCollectionPath)
        .add({
      UsersProfileTypeKeys.uid: user.uid,
      UsersProfileTypeKeys.type: userType
    });
  } on Exception catch (e) {
    /* print("MALARDOOOO"); */
    print(e);
  }
}
