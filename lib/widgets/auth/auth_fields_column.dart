import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:teachme_app/main.dart';

import 'auth_form.dart' show AuthMode;
import 'confirm_password_form_field.dart';
import 'password_form_field.dart';
import 'user_image_picker.dart';

class AuthFieldsColumn extends StatefulWidget {
  const AuthFieldsColumn({
    Key? key,
    required this.authMode,
    required this.onUserImageSaved,
    required this.onEmailSaved,
    required this.onUsernameSaved,
    required this.onPasswordSaved,
    required this.onUserProfileTypeSaved,
    this.currentUserImage,
    this.enabled,
    this.onSubmitted,
  }) : super(key: key);

  final AuthMode authMode;
  final void Function(File newValue) onUserImageSaved;
  final void Function(String? newValue) onEmailSaved;
  final void Function(String? newValue) onUsernameSaved;
  final void Function(String? newValue) onPasswordSaved;
  final void Function(ProfileType? newValue) onUserProfileTypeSaved;
  final File? currentUserImage;
  final bool? enabled;
  final void Function(String value)? onSubmitted;

  @override
  _AuthFieldsColumnState createState() => _AuthFieldsColumnState();
}

class _AuthFieldsColumnState extends State<AuthFieldsColumn> {
  ProfileType _internalProfileType = ProfileType.student;

  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  static final _usernameRegExp = RegExp(
    r"^(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$",
  );

  final _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const verticalSpace = SizedBox(height: 18.0);
    final isSigninMode = (widget.authMode == AuthMode.signin);

    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: theme.colorScheme.secondary,
          onPrimary: theme.colorScheme.onSecondary,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAnimatedChildVisibleOnCondition(
            condition: !isSigninMode,
            onInvisibleWidget: const SizedBox(height: 6.0),
            verticalSpace: verticalSpace,
            verticalSpaceLocation: VerticalDirection.down,
            child: UserImagePicker(
              pickImageCallback: widget.onUserImageSaved,
              initialImage: widget.currentUserImage,
              enabled: widget.enabled ?? true,
            ),
          ),
          TextFormField(
            enabled: widget.enabled,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value != null && _emailRegExp.hasMatch(value)) return null;
              return 'Ingrese una direcci??n de email v??lida.';
            },
            onSaved: widget.onEmailSaved,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
          ),
          _buildAnimatedChildVisibleOnCondition(
            condition: !isSigninMode,
            verticalSpace: verticalSpace,
            child: TextFormField(
              enabled: widget.enabled,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.length < 8 || value.length > 20) {
                  return 'El nombre de usuario debe contener entre 8 y 20 caracteres';
                } else if (!_usernameRegExp.hasMatch(value)) {
                  return 'El nombre de usuario solo debe contener letras y/o n??meros';
                }
                return null;
              },
              onSaved: widget.onUsernameSaved,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Nombre de usuario',
              ),
            ),
          ),
          verticalSpace,
          PasswordFormField(
            enabled: widget.enabled,
            controller: isSigninMode ? null : _passwordController,
            onSubmitted: isSigninMode ? widget.onSubmitted : null,
            onSaved: isSigninMode ? widget.onPasswordSaved : null,
          ),
          _buildAnimatedChildVisibleOnCondition(
              condition: !isSigninMode,
              verticalSpace: verticalSpace,
              child: Column(
                children: [
                  ConfirmPasswordFormField(
                    validator: (value) {
                      if (value == _passwordController.text) return null;
                      return 'Las contrase??as son diferentes.';
                    },
                    enabled: widget.enabled,
                    onFieldSubmitted: widget.onSubmitted,
                    onSaved: widget.onPasswordSaved,
                  ),
                  ListTile(
                      title: const Text('Estudiante'),
                      leading: Radio<ProfileType>(
                          value: ProfileType.student,
                          groupValue: _internalProfileType,
                          onChanged: (ProfileType? value) {
                            setState(() {
                              _internalProfileType = value!;
                              widget.onUserProfileTypeSaved(value);
                            });
                          })),
                  ListTile(
                      title: const Text('Maestro'),
                      leading: Radio<ProfileType>(
                          value: ProfileType.teacher,
                          groupValue: _internalProfileType,
                          onChanged: (ProfileType? value) {
                            setState(() {
                              _internalProfileType = value!;
                              widget.onUserProfileTypeSaved(value);
                            });
                          })),
                ],
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
