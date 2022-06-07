import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAutocomplete extends StatelessWidget {
  final List<String> kOptions;
  //final void Function(String? newValue) onSaved;

  CustomAutocomplete({Key? key, required List<String> this.kOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return kOptions.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      }
      //onSelected: onSaved
    );
  }
}
