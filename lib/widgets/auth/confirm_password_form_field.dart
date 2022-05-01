import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  const ConfirmPasswordFormField({
    required this.validator,
    required this.onSaved,
    this.enabled,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final String? Function(String? value) validator;
  final void Function(String? newValue) onSaved;
  final bool? enabled;
  final FocusNode? focusNode;
  final void Function(String value)? onFieldSubmitted;

  @override
  _ConfirmPasswordFormFieldState createState() {
    return _ConfirmPasswordFormFieldState();
  }
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      toolbarOptions: const ToolbarOptions(selectAll: true),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: InkWell(
          onTap: () => setState(() => _obscureText = !_obscureText),
          customBorder: const CircleBorder(),
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
