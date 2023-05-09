import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './application_history_screen.dart';

import '../widgets/custom_application_listtile.dart';

import '../models/company.dart';
import '../models/application.dart';

import '../constants.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  List<Application>? list;
  // Company? company;

  Future getApplications(Company company) async {
    list = await company.getApplications();
    // for (var element in list!) {
    //   await element.getApplicantInfo();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Company>(context);
    final deviceSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getApplications(company),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              company.name == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              backgroundColor: accentCanvasColor,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: CustomApplicationListTile(application: list![index]),
                    );
                  },
                ),
              ),
              floatingActionButton: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ApplicationHistotyScreen(),
                      transitionDuration: const Duration(seconds: 0),
                      reverseTransitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(primaryColor),
                  fixedSize: MaterialStatePropertyAll(
                      Size(deviceSize.width * 0.2, 45)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                child: const Text(
                  'Applications History',
                  style: TextStyle(
                      color: white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        },
      ),
    );
  }
}
