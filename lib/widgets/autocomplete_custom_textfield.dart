import 'package:flutter/material.dart';
import '../constants.dart';

// A custom text field form that has a label and a hint text.
// also has a validator to check if the input is empty or not.
// aslo has a theme that works with ios and android.

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class AutoCompleteCustomTextField extends StatefulWidget {
  String? hint;

  AutoCompleteCustomTextField({
    super.key,
    this.hint,
    required this.kOptions,
    this.entry,
    required this.getKeywords,
    required this.keysDoc,
    required this.label,
    this.controller,
  });

  late Map<String, List<String>?> kOptions;
  late String? entry;
  final Function getKeywords;
  final String label;
  final String keysDoc;
  TextEditingController? controller;

  @override
  State<AutoCompleteCustomTextField> createState() =>
      _AutoCompleteCustomTextFieldState();
}

class _AutoCompleteCustomTextFieldState
    extends State<AutoCompleteCustomTextField> {
  int? maxLines;

  Function? onChanged;

  Function? validator;

  bool isLoaded = false;

  Future getKeys() async {
    widget.kOptions = await widget.getKeywords(widget.keysDoc);
  }

  @override
  Widget build(BuildContext context) {
    // A custom text field form that has a label and a hint text.
// also has a validator to check if the input is empty or not.
// aslo has a theme that works with ios and android.
    final deviceSize = MediaQuery.of(context).size;
    if (!isLoaded) {
      getKeys();
      isLoaded = true;
    }
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        widget.kOptions = await widget.getKeywords(widget.keysDoc);
        return widget.kOptions[widget.keysDoc]!.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      initialValue: TextEditingValue(text: widget.controller!.text.toTitleCase()),
      onSelected: (String selection) {
        widget.controller!.text = selection.toLowerCase();
        setState(() {});
        debugPrint('You just selected $selection');
      },
      displayStringForOption: (option) => option.toTitleCase(),
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 200,
            height: deviceSize.height * 0.3,
            child: ListView.builder(
              padding: const EdgeInsets.all(3),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return Material(
                  child: InkWell(
                    onTap: () => onSelected(option),
                    child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      hoverColor: Colors.white,
                      title: Text(option.toTitleCase()),
                      tileColor: const Color.fromARGB(255, 165, 183, 192),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          cursorColor: kBlue,
          maxLines: maxLines,
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          style: const TextStyle(color: white),
          decoration: InputDecoration(
            // labelText: widget.label,
            // labelStyle: const TextStyle(color: Colors.white24),
            hintText: widget.hint,
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
            fillColor: white,
          ),
          validator: (value) {
            if (!widget.kOptions[widget.keysDoc]!.contains(value!.toLowerCase())) {
              return 'Not a valid entry!';
            }
          },
          // validator: (value) => validator(value),
          // //TODO: check correctnes of this line
          // onChanged: (value) => onChanged(value),
        );
      },
    );
  }
}
