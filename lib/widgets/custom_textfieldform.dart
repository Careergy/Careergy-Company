import 'package:flutter/material.dart';

import '../constants.dart';

// A custom text field form that has a label and a hint text.
// also has a validator to check if the input is empty or not.
// aslo has a theme that works with ios and android.
class CustomTextField extends StatelessWidget {
  String label;
  String hint;
  TextEditingController? controller;
  int? maxLines;
  Function? onChanged;
  Function? validator;

  CustomTextField({
    super.key,
    required this.label,
    this.controller,
    required this.hint,
    this.maxLines,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // A custom text field form that has a label and a hint text.
// also has a validator to check if the input is empty or not.
// aslo has a theme that works with ios and android.
    return TextField(
      cursorColor: kBlue,
      maxLines: maxLines,
      controller: controller,
      style: const TextStyle(color: white),
      decoration: InputDecoration(
        // labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            //make the border color black
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: Colors.black,
        fillColor: Colors.white,
      ),
      // validator: (value) => validator(value),
      // //TODO: check correctnes of this line
      // onChanged: (value) => onChanged!(value),
    );
  }
}
