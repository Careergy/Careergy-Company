import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './application_screen.dart';

import '../widgets/custom_application_listtile.dart';

import '../models/company.dart';
import '../models/application.dart';

import '../constants.dart';

class ApplicationHistotyScreen extends StatefulWidget {
  const ApplicationHistotyScreen({super.key});

  @override
  State<ApplicationHistotyScreen> createState() =>
      _ApplicationHistotyScreenState();
}

class _ApplicationHistotyScreenState extends State<ApplicationHistotyScreen> {
  List<Application>? list;

  void viewApplication(BuildContext ctx, Application application) {
    Navigator.of(ctx).push(
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

  Future getApplicationsHistory(Company company) async {
    list = await company.getApplicationsHistory();
  }

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Company>(context);
    final deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getApplicationsHistory(company),
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
                      color: white, fontSize: 16, fontWeight: FontWeight.bold),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
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
                          child: Text('Applications History',
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
                        child: list == null
                            ? const Center(
                                child: Text('No Records',
                                    style: TextStyle(color: white)))
                            : ListView.builder(
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
          );
        }
      },
    );
  }
}
