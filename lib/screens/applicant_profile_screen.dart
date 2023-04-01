import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:careergy_mobile/models/applicant.dart';

class ApplicantProfileScreen extends StatefulWidget {
  const ApplicantProfileScreen({super.key});

  @override
  State<ApplicantProfileScreen> createState() =>
      _ApplicantProfileScreenState('/applicant_profile');
}

class _ApplicantProfileScreenState extends State<ApplicantProfileScreen> {
  String? currentPage;
  _ApplicantProfileScreenState(this.currentPage);

  Applicant? viewedApplicant;
  Future viewApplicant(Applicant applicant) async {
    currentPage = '/applicant_profile';
    viewedApplicant = applicant;
    setState(() {});
  }

  List<bool> isSelected = [true, false];
  bool isPersonalShowed = true;

  @override
  Widget build(BuildContext context) {
    return currentPage == '/applicant_profile'
        ? FutureBuilder(
            builder: (context, snapshot) {
              // SearchResultArea(viewApplicant: viewApplicant);

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Scaffold(
                  body: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, bottom: 30, right: 50, left: 50),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        FittedBox(
                                          fit: BoxFit.fill,
                                          child: CircleAvatar(
                                            radius: 90,
                                            child: ClipOval(
                                              child: const Image(
                                                image: AssetImage(
                                                    '/avatarPlaceholder.png'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'info.name',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              Text(
                                                'info.major',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.email,
                                            color: kBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: ToggleButtons(
                                      borderRadius: BorderRadius.circular(10),
                                      borderColor: Colors.white,
                                      selectedColor: kBlue,
                                      disabledColor: Colors.white,
                                      textStyle: TextStyle(fontSize: 20),
                                      selectedBorderColor: kBlue,
                                      disabledBorderColor: Colors.grey,
                                      isSelected: isSelected,
                                      onPressed: (int index) {
                                        setState(() {
                                          for (int buttonIndex = 0;
                                              buttonIndex < isSelected.length;
                                              buttonIndex++) {
                                            if (buttonIndex == index) {
                                              isSelected[buttonIndex] = true;
                                            } else {
                                              isSelected[buttonIndex] = false;
                                            }
                                          }
                                        });
                                      },
                                      children: const <Widget>[
                                        SizedBox(
                                          width: 350,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Text('Personal Info'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 350,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Text('Applicant Info'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  isSelected[0]
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Email',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'info.email',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              const Text(
                                                'Phone Number',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'info.phone',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              const Text(
                                                'About',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 500,
                                                child: Text(
                                                  'info.bio',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text('Applicant'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )
        : Center();
  }
}
