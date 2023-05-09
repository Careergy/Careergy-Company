import 'package:flutter/material.dart';

import 'package:careergy_mobile/constants.dart';

class ApplicationHistotyScreen extends StatefulWidget {
  const ApplicationHistotyScreen({super.key});

  @override
  State<ApplicationHistotyScreen> createState() =>
      _ApplicationHistotyScreenState();
}

class _ApplicationHistotyScreenState extends State<ApplicationHistotyScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            backgroundColor: accentCanvasColor,
            floatingActionButton: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(primaryColor),
                  fixedSize: MaterialStatePropertyAll(
                      Size(deviceSize.width * 0.2, 45)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Placeholder();
                }
              },
            ),
          );
        }
      },
    );
  }
}
