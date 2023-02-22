import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  final String btnName;
  final String? routeName;
  Function func;
  bool selected;

  SidebarButton(
      {super.key,
      required this.btnName,
      this.routeName,
      this.selected = false,
      required this.func});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          color: Color.fromRGBO(0, 0, 0, 0),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: ElevatedButton(
            onPressed: () => func(routeName),
            child: Text(btnName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: selected
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(34, 22, 112, 0.6))),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(selected
                    ? Color.fromRGBO(34, 22, 112, 0.6)
                    : Color.fromRGBO(255, 255, 255, 1)),
                alignment: Alignment.centerLeft),
          ),
        ),
      ],
    );
  }
}
