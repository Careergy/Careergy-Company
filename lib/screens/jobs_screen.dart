import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';
import '../models/job.dart';
import '../widgets/custom_textfieldform.dart';
import 'jobs_list.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState('/jobs');
}

class _JobsScreenState extends State<JobsScreen> {
  String? currentPage;

  _JobsScreenState(this.currentPage);

  List<Job>? jobs = [
    Job(
        jobID: 1,
        jobTitle: "Flutter develober",
        yearsOfExperience: "1",
        major: "Software Engineer",
        descreption: "descreption1"),
    Job(
        jobID: 2,
        jobTitle: "Accountant",
        yearsOfExperience: "0",
        major: "Accountant",
        descreption: "descreption2"),
    Job(
        jobID: 3,
        jobTitle: "Math Teacher",
        yearsOfExperience: "0",
        major: "Teacher",
        descreption:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        city: "dammam"),
  ];

  @override
  Widget build(BuildContext context) {
    return currentPage == '/new_job'
        ? NewJobScreen()
        : Scaffold(
            body: Column(
              children: [
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          'ID',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Job Title',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Experience Years',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Major',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          'City',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Activation',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: jobs!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, Index) {
                      return JobsList(job: jobs![Index], onTap: () {});
                    }),
              ],
            ),
            floatingActionButton: ElevatedButton(
                onPressed: () => setState(() {
                      currentPage = '/new_job';
                    }),
                child: Icon(Icons.add)),
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
  List<String> _years = ['0', '1', '2', '3', '4', '5'];
  String? _selectedYear;

  List<String> _majors = [
    'Software Engineer',
    'Accountant',
    'Mechanical Engineer',
    'Marketer',
    'Teacher'
  ];
  String? _selectedMajor;
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
                              Row(
                                children: [
                                  Text(
                                    'Years of experience*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Employee Major*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      borderRadius: BorderRadius.circular(10),
                                      hint: Text(
                                          'Please choose a year'), // Not necessary for Option 1
                                      value: _selectedYear,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedYear = newValue;
                                        });
                                      },
                                      items: _years.map((year) {
                                        return DropdownMenuItem(
                                          child: new Text(year),
                                          value: year,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      borderRadius: BorderRadius.circular(10),
                                      hint: Text(
                                          'Please choose a major'), // Not necessary for Option 1
                                      value: _selectedMajor,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedMajor = newValue;
                                        });
                                      },
                                      items: _majors.map((major) {
                                        return DropdownMenuItem(
                                          child: new Text(major),
                                          value: major,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
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
