import 'package:flutter/material.dart';
import 'package:careergy_mobile/constants.dart';

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
            child: Text(
              btnName,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:
                    selected ? const Color.fromRGBO(255, 255, 255, 1) : kBlue,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                selected ? kBlue : const Color.fromRGBO(255, 255, 255, 0),
              ),
              shadowColor: MaterialStatePropertyAll(
                selected ? null : const Color.fromRGBO(255, 255, 255, 0),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ],
    );
  }
}
