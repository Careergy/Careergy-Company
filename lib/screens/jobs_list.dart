import 'package:flutter/material.dart';

class jobsList extends StatelessWidget {
  final String child;
  jobsList({required this.child, required Null Function() onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 200,
        width: 200,
        color: Colors.blue,
        child: Text(
          child,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
