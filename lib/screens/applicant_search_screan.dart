import 'dart:async';

import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../constants.dart';
import '../models/applicant.dart';

import '../widgets/search_result_area.dart';
import '../widgets/briefcv_field.dart';

import '../constants.dart' as constents;

class ApplicantSearchScreen extends StatefulWidget {
  const ApplicantSearchScreen({super.key});

  @override
  State<ApplicantSearchScreen> createState() => _ApplicantSearchScreenState();
}

class _ApplicantSearchScreenState extends State<ApplicantSearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  double _height = 500.0;
  bool animationDone = false;
  bool load = false;

  TextfieldTagsController majorsController = TextfieldTagsController();
  TextfieldTagsController jobTitleController = TextfieldTagsController();
  TextfieldTagsController majorSkillsController = TextfieldTagsController();
  TextfieldTagsController softSkillsController = TextfieldTagsController();
  TextfieldTagsController interestsController = TextfieldTagsController();
  TextfieldTagsController otherSkillsController = TextfieldTagsController();
  TextfieldTagsController locationsController = TextfieldTagsController();

  // Future searchApplicants() async {
  //   return await Applicant.getSearchResults(
  //     majorsController.getTags,
  //     jobTitleController.getTags,
  //     majorSkillsController.getTags,
  //     softSkillsController.getTags,
  //     interestsController.getTags,
  //     locationsController.getTags,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    if (!animationDone) {
      _height = deviceSize.height * 0.6;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: constents.accentCanvasColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: _height,
                curve: Curves.fastOutSlowIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: constents.canvasColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: List.filled(
                              4,
                              const BoxShadow(
                                  blurRadius: 1.2,
                                  blurStyle: BlurStyle.normal,
                                  color: Colors.black38))),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 280,
                        // width: deviceSize.width * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 15, right: 30, left: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('\t\t\t\tMajor:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Major:',
                                              controller: majorsController,
                                              keysName: 'majors',
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('\t\t\t\Job Title:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Job Title:',
                                              controller: jobTitleController,
                                              keysName: 'job_titles',
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('\t\t\t\tMajor Skills:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Major Skills:',
                                              controller: majorSkillsController,
                                              keysName: 'major_skills',
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('\t\t\t\Soft Skills:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Soft Skills:',
                                              controller: softSkillsController,
                                              keysName: 'soft_skills',
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('\t\t\t\tInterests:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Interests:',
                                              controller: interestsController,
                                              keysName: 'intrests',
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                        width: deviceSize.width * 0.34,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                '\t\t\t\Prefered Locations:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            BriefCVField(
                                              label: 'Prefered Locations:',
                                              controller: locationsController,
                                              keysName: 'locations',
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _height = 280.0;
                                      animationDone = true;
                                    });
                                    Timer(const Duration(seconds: 1), () {
                                      setState(() {
                                        load = true;
                                      });
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    width: deviceSize.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(20), 
                                    ),
                                    child: const Center(child: Text('Search', style: TextStyle(color: white))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              load
                  ? SearchResultArea(
                      interestsController: interestsController,
                      jobTitleController: jobTitleController,
                      locationsController: locationsController,
                      majorSkillsController: majorSkillsController,
                      majorsController: majorsController,
                      softSkillsController: softSkillsController,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
