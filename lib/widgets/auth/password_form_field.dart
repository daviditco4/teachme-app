import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    this.enabled,
    this.controller,
    this.onSubmitted,
    this.onSaved,
  });

  final bool? enabled;
  final TextEditingController? controller;
  final void Function(String value)? onSubmitted;
  final void Function(String? newValue)? onSaved;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  static final _alphaRegExp = RegExp('[a-zA-Z]');
  static final _digitRegExp = RegExp('[0-9]');
  static final _passwordRegExp = RegExp(r'^[a-zA-Z0-9!@#$%&*]+$');

  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final signinMode = (widget.onSaved != null);

    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: signinMode ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: signinMode ? widget.onSubmitted : null,
      validator: (val) {
        if (val == null || val.length < 6 || val.length > 20) {
          return 'The password must have between 6 and 20 characters in total.';
        } else if (!val.contains(_digitRegExp) || !val.contains(_alphaRegExp)) {
          return 'The password must contain at least one letter and one digit.';
        } else if (!_passwordRegExp.hasMatch(val)) {
          return 'The password must only contain letters, numbers '
              r'or any of the following characters: ! @ # $ % & *';
        }
        return null;
      },
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        icon: const Icon(Icons.password),
        labelText: 'Password',
        suffixIcon: InkWell(
          canRequestFocus: false,
          onTap: () => setState(() => _obscureText = !_obscureText),
          customBorder: const CircleBorder(),
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
