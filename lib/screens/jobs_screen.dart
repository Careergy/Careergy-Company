import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';
import '../widgets/custom_textfieldform.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState('/jobs');
}

class _JobsScreenState extends State<JobsScreen> {
  String? currentPage;
  _JobsScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return currentPage == '/new_job'
        ? NewJobScreen()
        : Scaffold(
            body: ListView(children: [
              Text("post a job"),
              ElevatedButton(
                  onPressed: () => setState(() {
                        currentPage = '/new_job';
                      }),
                  child: Icon(Icons.add))
            ]),
          );
  }
}

class NewJobScreen extends StatefulWidget {
  const NewJobScreen({super.key});

  @override
  State<NewJobScreen> createState() => _NewJobScreenState('/new_job');
}

class _NewJobScreenState extends State<NewJobScreen> {
  String? currentPage;
  Image? photo = Image.asset('/avatarPlaceholder.png');
  _NewJobScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return currentPage == '/jobs'
        ? JobsScreen()
        : Scaffold(
            body: ListView(children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 100, bottom: 30, right: 50, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job Title*',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 300,
                                child: CustomTextField(
                                  label: "Title",
                                  hint: "Enter Title",
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Target Employee Type*',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 200,
                                child: CustomTextField(
                                  label: "Type",
                                  hint: "Enter Type",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 50, bottom: 30, right: 50),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 240,
                                width: 240,
                                child: Stack(
                                  children: [
                                    ClipOval(
                                      child: photo,
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 20,
                                      child: MaterialButton(
                                        minWidth: 30,
                                        onPressed: () => {},
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                          color: kBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 30, right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Job Description*',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 500,
                            child: CustomTextField(
                              label: "Job description",
                              hint: "Enter descritpion",
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = '/jobs';
                                // save job info in the database
                              });
                            },
                            child: const Text('add'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentPage = '/jobs';
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
  }
}
