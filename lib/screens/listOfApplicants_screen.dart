import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListOfApplicantsScreen extends StatefulWidget {
  const ListOfApplicantsScreen({super.key});

  @override
  State<ListOfApplicantsScreen> createState() => _ListOfApplicantsScreenState();
}

class _ListOfApplicantsScreenState extends State<ListOfApplicantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'List of Applicants Screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
