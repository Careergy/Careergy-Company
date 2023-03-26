import 'package:careergy_mobile/providers/keywords_provider.dart';
import 'package:careergy_mobile/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';
import '../models/job.dart';
import '../widgets/custom_textfieldform.dart';
import '../widgets/autocomplete_custom_textfield.dart';
import 'jobs_list.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState('/jobs');
}

class _JobsScreenState extends State<JobsScreen> {
  String? currentPage;

  _JobsScreenState(this.currentPage);

  late List jobs = [];
  late final Future myFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = getPosts();
  }

  Future getPosts() async {
    jobs = await Post().getPosts() as List;
  }

  // List<Job>? jobs = [
  //   Job(
  //       jobTitle: "Flutter develober",
  //       yearsOfExperience: "1",
  //       major: "Software Engineer",
  //       descreption: "descreption1",
  //       city: "dammam"),
  //   Job(
  //       jobTitle: "Accountant",
  //       yearsOfExperience: "0",
  //       major: "Accountant",
  //       descreption: "descreption2",
  //       city: "dammam"),
  //   Job(
  //       jobTitle: "Math Teacher",
  //       yearsOfExperience: "0",
  //       major: "Teacher",
  //       descreption:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  //       city: "dammam"),
  // ];

  Future refresh() async {
    await getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return currentPage == '/new_job'
        ? const NewJobScreen()
        : FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                // print(jobs[0]);
                return Scaffold(
                  body: Column(
                    children: [
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 50,
                              child: Text(
                                'Date',
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
                                'Action',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: jobs.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, Index) {
                            return JobsList(job: jobs[Index], refresh: refresh);
                          }),
                    ],
                  ),
                  floatingActionButton: ElevatedButton(
                      onPressed: () => setState(() {
                            currentPage = '/new_job';
                          }),
                      child: const Icon(Icons.add)),
                );
              }
            },
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
  final List<String> _years = ['0', '1', '2', '3', '4', '5', '6', '7', '8+'];
  late List items = [];

  String? _selectedYear;
  String? city;

  TextEditingController major = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, List<String>> _kOptions = {
    'job_titles': [],
    'majors': [],
  };
  late String listType = '';

  var _isLoading = false;

  Future<Map<String, List<String>?>> getKeywords(String type) async {
    if (_kOptions.isEmpty || (type != listType)) {
      _kOptions[type] = await Keywords().getKeywords(type);
      listType = type;
    }
    setState(() {});
    print(_kOptions);
    return _kOptions;
  }

  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    // Assign that variable your Future.
    myFuture = getCities();
  }

  Future<void> getCities() async {
    items = await Keywords().getKeywords('locations');
  }

  _NewJobScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    getCities();
    return currentPage == '/jobs'
        ? const JobsScreen()
        : FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                print(items);
                return Scaffold(
                  body: ListView(children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 30, right: 50, left: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'Job Title*',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child:
                                                    AutoCompleteCustomTextField(
                                                  label: "Title",
                                                  hint: "Enter Title",
                                                  controller: title,
                                                  kOptions: _kOptions,
                                                  getKeywords: getKeywords,
                                                  keysDoc: 'job_titles',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'Major*',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child:
                                                    AutoCompleteCustomTextField(
                                                  label: "Major",
                                                  hint: "Enter Major",
                                                  controller: major,
                                                  kOptions: _kOptions,
                                                  getKeywords: getKeywords,
                                                  keysDoc: 'majors',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            'Years of experience*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            'City*',
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              hint: const Text(
                                                  'Please choose a year'), // Not necessary for Option 1
                                              value: _selectedYear,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedYear = newValue;
                                                });
                                              },
                                              items: _years.map((year) {
                                                return DropdownMenuItem(
                                                  value: year,
                                                  child: Text(year),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              hint: const Text(
                                                  'Please choose a City'), // Not necessary for Option 1
                                              value: city,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  city = newValue.toString();
                                                });
                                              },
                                              items: items
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e
                                                                .toString()
                                                                .substring(0, 1)
                                                                .toUpperCase() +
                                                            e
                                                                .toString()
                                                                .substring(1),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
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
                              padding: const EdgeInsets.only(
                                  left: 30, bottom: 30, right: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Job Description*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                                      controller: description,
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
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        // Invalid!
                                        return;
                                      }
                                      _formKey.currentState!.save();
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await Post().postJob(Job(
                                          jobTitle: title.text,
                                          yearsOfExperience:
                                              _selectedYear ?? '',
                                          major: major.text,
                                          descreption: description.text,
                                          city: city ?? '',
                                          isActive: true));
                                      setState(() {
                                        _isLoading = false;
                                        currentPage = '/jobs';
                                        // save job info in the database
                                      });
                                    },
                                    child: const Text('add'),
                                  ),
                                  const SizedBox(
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
                    ),
                  ]),
                );
              }
            },
          );
  }
}
