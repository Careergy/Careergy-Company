import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keywords_provider.dart';
import '../providers/post_provider.dart';
import '../models/job.dart';

import '../widgets/custom_textfieldform.dart';
import '../widgets/autocomplete_custom_textfield.dart';
import 'jobs_list.dart';

import '../constants.dart';
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
    super.initState();
    myFuture = getPosts();
  }

  Future getPosts() async {
    jobs = await Post.getPosts() as List;
  }

  Future refresh() async {
    await getPosts();
    setState(() {});
  }

  Job? editJob;
  Future editingPage(Job job) async {
    currentPage = '/new_job';
    editJob = job;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return currentPage == '/new_job'
        ? editJob != null
            ? NewJobScreen(job: editJob)
            : NewJobScreen()
        : Scaffold(
            backgroundColor: accentCanvasColor,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () => setState(() {
                  currentPage = '/new_job';
                }),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(
                      primaryColor), // <-- Button color
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return actionColor; // <-- Splash color
                      }
                    },
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                          child: Text('Posted Jobs',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800))),
                    ),
                    const SizedBox(height: 8),
                    divider,
                    FutureBuilder(
                        future: myFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: deviceSize.height * 0.345),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          } else {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: ListView.builder(
                                  itemCount: jobs.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return JobsList(
                                      job: jobs[index],
                                      refresh: refresh,
                                      editingPage: editingPage,
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}

class NewJobScreen extends StatefulWidget {
  NewJobScreen({super.key, this.job});

  Job? job;

  @override
  State<NewJobScreen> createState() => _NewJobScreenState('/new_job');
}

class _NewJobScreenState extends State<NewJobScreen> {
  String? currentPage;
  final List<String> _years = [
    'Not Specified',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8+'
  ];
  final List<String> _types = [
    'full-time',
    'part-time',
    'internship',
    'zero-hour',
    'casual',
    'freelance',
    'union',
    'executive',
    'fixed-term'
  ];
  late List items = [];

  String? _selectedYear = 'Not Specified';
  String? _selectedType = 'full-time';
  String? city = 'not specified';

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
    return _kOptions;
  }

  bool isLoaded = false;
  late final Future myFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   // Assign that variable your Future.
  //   myFuture = getCities();
  // }
  bool isActive = false;
  Future<void> getCities() async {
    if (!isActive) {
      items = await Keywords().getKeywords('locations');
      isActive = true;
    }
  }

  _NewJobScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    if ((widget.job != null) && !isLoaded) {
      major = TextEditingController.fromValue(
          TextEditingValue(text: widget.job!.major));
      title = TextEditingController.fromValue(
          TextEditingValue(text: widget.job!.jobTitle));
      description = TextEditingController.fromValue(
          TextEditingValue(text: widget.job!.descreption));
      city = widget.job!.city;
      _selectedYear = widget.job!.yearsOfExperience;
      _selectedType = widget.job!.type;
      isLoaded = true;
    }
    final deviceSize = MediaQuery.of(context).size;
    return currentPage == '/jobs'
        ? const JobsScreen()
        : Scaffold(
            backgroundColor: accentCanvasColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Container(
                height: deviceSize.height * 0.7,
                padding: const EdgeInsets.only(top: 8.0),
                decoration: const BoxDecoration(
                    color: canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      width: deviceSize.width * 0.2,
                      decoration: const BoxDecoration(
                        color: titleBackground,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                          child: Text(
                              widget.job != null ? 'Edit Job' : 'Add New Job',
                              style: const TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800))),
                    ),
                    const SizedBox(height: 8),
                    divider,
                    FutureBuilder(
                      future: getCities(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Job Title:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
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
                                            const SizedBox(height: 60),
                                            const Text(
                                              'Major:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Years of experience:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: DropdownButton(
                                                alignment: Alignment.center,
                                                style: const TextStyle(
                                                    color: white),
                                                dropdownColor: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                hint: const Text(
                                                    'Please choose a number',
                                                    style: TextStyle(
                                                        color:
                                                            white)), // Not necessary for Option 1
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
                                            const SizedBox(height: 18),
                                            const Text(
                                              'Contract Type:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: DropdownButton(
                                                alignment: Alignment.center,
                                                style: const TextStyle(
                                                    color: white),
                                                dropdownColor: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                hint: const Text(
                                                    'Please choose a type',
                                                    style: TextStyle(
                                                        color:
                                                            white)), // Not necessary for Option 1
                                                value: _selectedType,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedType = newValue;
                                                  });
                                                },
                                                items: _types.map((type) {
                                                  return DropdownMenuItem(
                                                    value: type,
                                                    child: Text(type.toUpperCase()),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            const SizedBox(height: 18),
                                            const Text(
                                              'City:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: DropdownButton(
                                                alignment: Alignment.center,
                                                style: const TextStyle(
                                                    color: white),
                                                dropdownColor: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                hint: const Text(
                                                    'Please choose a City',
                                                    style: TextStyle(
                                                        color:
                                                            white)), // Not necessary for Option 1
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
                                                                  .substring(
                                                                      0, 1)
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
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Job Description:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 500,
                                              child: CustomTextField(
                                                label: "Job Description",
                                                hint: "Enter descritpion",
                                                maxLines: 10,
                                                controller: description,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    primaryColor),
                                            fixedSize: MaterialStatePropertyAll(
                                                Size(deviceSize.width * 0.1,
                                                    45)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                          onPressed: () async {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              // Invalid!
                                              return;
                                            }
                                            _formKey.currentState!.save();
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            if (widget.job != null) {
                                              await Post.editPost(Job(
                                                id: widget.job!.id,
                                                jobTitle: title.text,
                                                yearsOfExperience:
                                                    _selectedYear ?? '',
                                                major: major.text,
                                                type: _selectedType ?? '',
                                                descreption: description.text,
                                                city: city ?? '',
                                              ));
                                            } else {
                                              await Post.postJob(Job(
                                                jobTitle: title.text,
                                                yearsOfExperience:
                                                    _selectedYear ?? '',
                                                major: major.text,
                                                descreption: description.text,
                                                type: _selectedType ?? '',
                                                city: city ?? '',
                                                isActive: true,
                                              ));
                                            }
                                            setState(() {
                                              _isLoading = false;
                                              currentPage = '/jobs';
                                              // save job info in the database
                                            });
                                          },
                                          child: widget.job != null
                                              ? _isLoading
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 3,
                                                    )
                                                  : const Text('Save',
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800))
                                              : _isLoading
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 3,
                                                    )
                                                  : const Text('Add',
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.blueGrey),
                                            fixedSize: MaterialStatePropertyAll(
                                                Size(deviceSize.width * 0.1,
                                                    45)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              currentPage = '/jobs';
                                            });
                                          },
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );

    // return ListView(children: [
    //   Container(
    //     padding: const EdgeInsets.all(20),
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(
    //                     top: 10, bottom: 30, right: 50, left: 30),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Column(
    //                           children: [
    //                             const Text(
    //                               'Job Title*',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                             const SizedBox(
    //                               height: 20,
    //                             ),
    //                             SizedBox(
    //                               width: 300,
    //                               child: AutoCompleteCustomTextField(
    //                                 label: "Title",
    //                                 hint: "Enter Title",
    //                                 controller: title,
    //                                 kOptions: _kOptions,
    //                                 getKeywords: getKeywords,
    //                                 keysDoc: 'job_titles',
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(
    //                           width: 40,
    //                         ),
    //                         Column(
    //                           children: [
    //                             const Text(
    //                               'Major*',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                             const SizedBox(
    //                               height: 20,
    //                             ),
    //                             SizedBox(
    //                               width: 300,
    //                               child: AutoCompleteCustomTextField(
    //                                 label: "Major",
    //                                 hint: "Enter Major",
    //                                 controller: major,
    //                                 kOptions: _kOptions,
    //                                 getKeywords: getKeywords,
    //                                 keysDoc: 'majors',
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     Row(
    //                       children: const [
    //                         Text(
    //                           'Years of experience*',
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 20),
    //                         ),
    //                         SizedBox(
    //                           width: 30,
    //                         ),
    //                         Text(
    //                           'City*',
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 20),
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [
    //                         SizedBox(
    //                           width: 200,
    //                           child: DropdownButton(
    //                             alignment: Alignment.center,
    //                             borderRadius: BorderRadius.circular(10),
    //                             hint: const Text(
    //                                 'Please choose a year'), // Not necessary for Option 1
    //                             value: _selectedYear,
    //                             onChanged: (newValue) {
    //                               setState(() {
    //                                 _selectedYear = newValue;
    //                               });
    //                             },
    //                             items: _years.map((year) {
    //                               return DropdownMenuItem(
    //                                 value: year,
    //                                 child: Text(year),
    //                               );
    //                             }).toList(),
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           width: 20,
    //                         ),
    //                         SizedBox(
    //                           width: 200,
    //                           child: DropdownButton(
    //                             alignment: Alignment.center,
    //                             borderRadius: BorderRadius.circular(10),
    //                             hint: const Text(
    //                                 'Please choose a City'), // Not necessary for Option 1
    //                             value: city,
    //                             onChanged: (newValue) {
    //                               setState(() {
    //                                 city = newValue.toString();
    //                               });
    //                             },
    //                             items: items
    //                                 .map(
    //                                   (e) => DropdownMenuItem(
    //                                     value: e,
    //                                     child: Text(
    //                                       e
    //                                               .toString()
    //                                               .substring(0, 1)
    //                                               .toUpperCase() +
    //                                           e.toString().substring(1),
    //                                     ),
    //                                   ),
    //                                 )
    //                                 .toList(),
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 20,
    //               ),
    //             ],
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 30, bottom: 30, right: 50),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Job Description*',
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //                 SizedBox(
    //                   width: 500,
    //                   child: CustomTextField(
    //                     label: "Job description",
    //                     hint: "Enter descritpion",
    //                     maxLines: 10,
    //                     controller: description,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(32.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: () async {
    //                     if (!_formKey.currentState!.validate()) {
    //                       // Invalid!
    //                       return;
    //                     }
    //                     _formKey.currentState!.save();
    //                     setState(() {
    //                       _isLoading = true;
    //                     });
    //                     if (widget.job != null) {
    //                       await Post.editPost(Job(
    //                         id: widget.job!.id,
    //                         jobTitle: title.text,
    //                         yearsOfExperience: _selectedYear ?? '',
    //                         major: major.text,
    //                         descreption: description.text,
    //                         city: city ?? '',
    //                       ));
    //                     } else {
    //                       await Post.postJob(Job(
    //                         jobTitle: title.text,
    //                         yearsOfExperience: _selectedYear ?? '',
    //                         major: major.text,
    //                         descreption: description.text,
    //                         city: city ?? '',
    //                         isActive: true,
    //                       ));
    //                     }
    //                     setState(() {
    //                       _isLoading = false;
    //                       currentPage = '/jobs';
    //                       // save job info in the database
    //                     });
    //                   },
    //                   child: widget.job != null
    //                       ? _isLoading
    //                           ? const CircularProgressIndicator(
    //                               color: Colors.white,
    //                               strokeWidth: 3,
    //                             )
    //                           : const Text('Save')
    //                       : _isLoading
    //                           ? const CircularProgressIndicator(
    //                               color: Colors.white,
    //                               strokeWidth: 3,
    //                             )
    //                           : const Text('Add'),
    //                 ),
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //                 TextButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       currentPage = '/jobs';
    //                     });
    //                   },
    //                   child: const Text('Cancel'),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ]);
    // }
    // },
    // ),
    // );
  }
}
