import 'dart:io' show File;

import 'package:flutter/material.dart';

import '../../helpers/snack_bars.dart';
import 'auth_fields_column.dart';

enum AuthMode { signin, signup }

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

      final success = await widget.onFormSubmitted(
        context: context,
        userImage: _pickedUserImage,
        authData: _userInput,
        signup: _authMode == AuthMode.signup,
      );

      if (!success) setState(() => _isLoading = false);
    }
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
            AuthFieldsColumn(
              authMode: _authMode,
              onUserImageSaved: (newValue) => _pickedUserImage = newValue,
              onEmailSaved: (newValue) => _userInput['email'] = newValue!,
              onUsernameSaved: (newValue) => _userInput['username'] = newValue!,
              onPasswordSaved: (newValue) => _userInput['password'] = newValue!,
              currentUserImage: _pickedUserImage,
              enabled: !_isLoading,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24.0),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                child: SizedBox(child: LinearProgressIndicator()),
              )
            else
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('Sign ${isSigninMode ? 'Up' : 'In'} Instead'),
                    onPressed: _switchAuthMode,
                  ),
                  ElevatedButton(
                    child: Text('Sign ${isSigninMode ? 'In' : 'Up'}'),
                    onPressed: _submit,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
