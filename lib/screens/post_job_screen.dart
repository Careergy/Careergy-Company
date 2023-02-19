import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class postJobScreen extends StatefulWidget {
  const postJobScreen({super.key});

  @override
  State<postJobScreen> createState() => _postJobScreenState();
}

class _postJobScreenState extends State<postJobScreen> {
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
                'Post a Job Screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
