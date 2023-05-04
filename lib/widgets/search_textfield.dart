import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchTextfield extends StatefulWidget {
  SearchTextfield(
      {super.key,
      required this.kOptions,
      required this.entriesList,
      required this.getKeywords,
      required this.keysDoc,
      required this.label});

  late List<String> kOptions;
  final List<String> entriesList;
  final Function getKeywords;
  final String label;
  final String keysDoc;

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class _SearchTextfieldState extends State<SearchTextfield> {
  void deleteItem(int index) {
    setState(() {
      widget.entriesList.removeAt(index);
    });
  }

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              widget.kOptions = await widget.getKeywords(widget.keysDoc);
              return widget.kOptions.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              widget.entriesList.add(selection);
              setState(() {});
              debugPrint('You just selected $selection');
            },
            displayStringForOption: (option) => '',
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 250,
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
                            tileColor: const Color.fromARGB(255, 170, 201, 216),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) =>
                    TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              decoration: InputDecoration(labelText: widget.label),
            ),
          ),
          SizedBox(
            width: ((deviceSize.width * 0.8) / 3) - 1,
            height: 35,
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              thickness: 5,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.entriesList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                widget.entriesList[index]
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    widget.entriesList[index].substring(1),
                                style: const TextStyle(color: Colors.white)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: IconButton(
                                onPressed: () => deleteItem(index),
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}