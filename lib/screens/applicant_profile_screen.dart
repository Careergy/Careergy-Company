import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/screens/new_offer_Job_screen.dart';
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
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: kBlue,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.12,
                      left: 40,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CircleAvatar(
                            radius: 120,
                            child: ClipOval(child: widget.applicant!.photo),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 310),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.applicant!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(kBlue)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        'Offer job',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewOfferJobScreen(),
                                      ),
                                    );
                                  });
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 30),
                        child: SizedBox(
                          width: 500,
                          child: Text(
                            widget.applicant!.bio == ''
                                ? 'No Bio'
                                : '${widget.applicant!.bio}',
                            style: TextStyle(
                                fontWeight: widget.applicant!.bio == ''
                                    ? FontWeight.w100
                                    : FontWeight.normal,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -20.0,
                      blurRadius: 20.0,
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 75.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: kBlue,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        widget.applicant!.email,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: kBlue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        widget.applicant!.phone ??
                                            'Not Available',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: SizedBox(
                                width: 1,
                                height: 400,
                                child: Container(color: Colors.grey.shade200),
                              ),
                            ),
                            SizedBox(
                              width: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'info.job_titles1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            'info.job_titles2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'info.level1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            'info.level2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'info.major1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            'info.major2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'info.major_skills1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            'info.major_skills2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.grey),
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
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                      const Text(
                                        'info.soft_skills2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                      const Text(
                                        'info.soft_skills3',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
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
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                      const Text(
                                        'info.intrests2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
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
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                      const Text(
                                        'info.locations2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            color: Colors.grey),
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: kBlue)),
                                    child: ListTile(
                                      title: const Text('Attachment1.pdf'),
                                      leading: CircleAvatar(
                                        backgroundColor: kBlue,
                                        child: InkWell(
                                          onTap: () {
                                            //download attachment
                                          },
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: kBlue)),
                                    child: ListTile(
                                      title: const Text('Attachment2.pdf'),
                                      leading: CircleAvatar(
                                        backgroundColor: kBlue,
                                        child: InkWell(
                                          onTap: () {
                                            //download attachment
                                          },
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
                        SizedBox(
                          height: 50,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
