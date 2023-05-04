import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:careergy_mobile/models/applicant.dart';

class ApplicantProfileScreen extends StatefulWidget {
  ApplicantProfileScreen({super.key, this.toggle, this.applicant});

  Applicant? applicant;
  Function? toggle;

  @override
  State<ApplicantProfileScreen> createState() => _ApplicantProfileScreenState();
}

class _ApplicantProfileScreenState extends State<ApplicantProfileScreen> {
  _ApplicantProfileScreenState();

  List<bool> isSelected = [true, false];
  bool isPersonalShowed = true;
  bool downloaded = false;

  Future getApplicantInfo(String id) async {
    if (!downloaded) {
      widget.applicant = await Applicant.getApplicantInfo(id);
      downloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getApplicantInfo(widget.applicant!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            floatingActionButton: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: CircleAvatar(
                                      radius: 90,
                                      child: ClipOval(
                                          child: widget.applicant!.photo),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.applicant!.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.email,
                                      color: kBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Divider(),
                            Center(
                              child: ToggleButtons(
                                borderRadius: BorderRadius.circular(10),
                                borderColor: Colors.white,
                                selectedColor: kBlue,
                                disabledColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
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
                            const SizedBox(
                              height: 20,
                            ),
                            isSelected[0]
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                            widget.applicant!.bio == ''
                                                ? 'Not Available'
                                                : widget.applicant!.bio ??
                                                    'Not Available',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
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
                                          widget.applicant!.email,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
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
                                          widget.applicant!.phone == ''
                                              ? 'Not Available'
                                              : widget.applicant!.phone ??
                                                  'Not Available',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'job Title',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'info.job_titles1',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                                const Text(
                                                  'info.job_titles2',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Level',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'info.level1',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                                const Text(
                                                  'info.level2',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Major',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'info.major1',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                                const Text(
                                                  'info.major2',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Major Skills',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'info.major_skills1',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                                const Text(
                                                  'info.major_skills2',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Divider(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Soft Skills',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'info.soft_skills1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            const Text(
                                              'info.soft_skills2',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            const Text(
                                              'info.soft_skills3',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Intrests',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'info.intrests1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            const Text(
                                              'info.intrests2',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Text(
                                              'preferred locations',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'info.locations1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            const Text(
                                              'info.locations2',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        const Text(
                                          'Attachments',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(color: kBlue)),
                                          child: ListTile(
                                            title:
                                                const Text('Attachment1.pdf'),
                                            leading: CircleAvatar(
                                              backgroundColor: kBlue,
                                              child: InkWell(
                                                onTap: () {},
                                                child: const ClipOval(
                                                  child: Icon(
                                                    Icons.download,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(color: kBlue)),
                                          child: ListTile(
                                            title:
                                                const Text('Attachment2.pdf'),
                                            leading: CircleAvatar(
                                              backgroundColor: kBlue,
                                              child: InkWell(
                                                onTap: () {},
                                                child: const ClipOval(
                                                  child: Icon(
                                                    Icons.download,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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
    );
  }
}
