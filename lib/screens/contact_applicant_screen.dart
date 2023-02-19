import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContactApplicantScreen extends StatefulWidget {
  const ContactApplicantScreen({super.key});

  @override
  State<ContactApplicantScreen> createState() => _ContactApplicantScreenState();
}

class _ContactApplicantScreenState extends State<ContactApplicantScreen> {
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
                'Jobs Screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
