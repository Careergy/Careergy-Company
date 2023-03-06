import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class postJobScreen extends StatefulWidget {
  const postJobScreen({super.key});

  @override
  State<postJobScreen> createState() => _postJobScreenState('/post_offer');
}

class _postJobScreenState extends State<postJobScreen> {
  String? currentPage;
  _postJobScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Text("post an offer"),
      ]),
    );
  }
}
