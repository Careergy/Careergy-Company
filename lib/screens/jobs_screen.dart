import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';
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

  final List posts = [
    'Job Title: Software \nYears of Experience : 5 \nSalary : 5000 \nDescription : Flutter developer',
    'Job Title: Mechanical \nYears of Experience : 3 \nSalary : 6000 \nDescription : Work in sites',
    'Job Title: Petrolium \nYears of Experience : 2 \nSalary : 4000 \nDescription : Dhahran site',
    'Job Title: Software \nYears of Experience : 5 \nSalary : 5000 \nDescription : Flutter developer',
    'Job Title: Mechanical \nYears of Experience : 3 \nSalary : 6000 \nDescription : Work in sites',
    'Job Title: Petrolium \nYears of Experience : 2 \nSalary : 4000 \nDescription : Dhahran site'
  ];
  @override
  Widget build(BuildContext context) {
    return currentPage == '/new_job'
        ? NewJobScreen()
        : Scaffold(
            body: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, Index) {
                  return jobsList(child: posts[Index], onTap: () {});
                }),
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
