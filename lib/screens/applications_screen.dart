import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './application_history_screen.dart';
import './application_screen.dart';

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

  void viewApplication(BuildContext cxt, Application application) {
    Navigator.of(cxt).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ApplicationScreen(application: application);
        },
      ),
    ).then((value) {
      if (value == null) {
        return;
      }
      if (!value) {
        setState(() {});
      }
    });
  }

  Future getApplications(Company company) async {
    list = await company.getApplications();
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  decoration: const BoxDecoration(
                    color: canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        width: deviceSize.width * 0.2,
                        decoration: const BoxDecoration(
                          color: titleBackground,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Center(
                            child: Text('Current Applications',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800))),
                      ),
                      const SizedBox(height: 8),
                      divider,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 40),
                          child: ListView.builder(
                            itemCount: list!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: CustomApplicationListTile(
                                  application: list![index],
                                  viewApplication: viewApplication,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      color: white, fontSize: 17, fontWeight: FontWeight.bold),
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
