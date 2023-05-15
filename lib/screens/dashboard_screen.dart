import 'package:careergy_mobile/providers/meetings_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_core/theme.dart';

// import '../screens/jobs_list.dart';
import './database_manager.dart';

import '../models/job.dart';
import '../models/application.dart';

import '../providers/post_provider.dart';

import '../constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState('/DashboardScreen');
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? currentPage;
  final auth = FirebaseAuth.instance;

  _DashboardScreenState(this.currentPage);
  late List jobs = [];
  late final Future myFuture;

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

  void getAppointments() async {
    return  Application.getAppointments(auth.currentUser!.uid);
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: accentCanvasColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: deviceSize.height * 0.26,
                  width: deviceSize.width * 0.4,
                  decoration: const BoxDecoration(
                      color: canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                Container(
                  height: deviceSize.height * 0.57,
                  width: deviceSize.width * 0.4,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.03,
                        child: const Text('Active Job Offers', style: TextStyle(color: white)),
                      ),
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
                              return Container(
                                height: deviceSize.height * 0.5,
                                width: deviceSize.width * 0.385,
                                child: Expanded(
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
                          divider,
                    ],
                  ),
                ),
              ],
            ),
            // This container for the calender
            Container(
              height: double.infinity,
              width: deviceSize.width * 0.4,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SfCalendarTheme(
                  data: SfCalendarThemeData(
                    backgroundColor: white,
                  ),
                  child: SfCalendar(
                    view: CalendarView.week,
                    // dataSource: MeetingDataSource(getAppointments() as List<Appointment>),
                    allowViewNavigation: true,
                    showNavigationArrow: true,
                    showDatePickerButton: true,
                    controller: CalendarController(),
                  )),
            )
          ],
        ),
      ),
      // body: ListView(children: [
      //   Container(
      //     margin: const EdgeInsets.fromLTRB(50, 50, 50, 20),
      //     padding: const EdgeInsets.all(50),
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         border: Border.all(color: kBlue)),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             const SizedBox(
      //               width: 160,
      //               child: Text(
      //                 'This Month',
      //                 style: TextStyle(
      //                     fontSize: 25, fontFamily: 'Montserrat_bold'),
      //               ),
      //             ),
      //             const SizedBox(
      //               width: 50,
      //               child: Text(
      //                 '|',
      //                 style: TextStyle(fontSize: 80, color: kBlue),
      //               ),
      //             ),
      //             Column(
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         'Accepted',
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontFamily: 'Montserrat_regular'),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         'Rejected',
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontFamily: 'Montserrat_regular'),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         'Jobs',
      //                         style: TextStyle(fontSize: 20),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         '150',
      //                         style: TextStyle(
      //                             fontFamily: 'Montserrat_bold',
      //                             fontSize: 50,
      //                             color: kBlue),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         '30',
      //                         style: TextStyle(
      //                             fontFamily: 'Montserrat_bold',
      //                             fontSize: 50,
      //                             color: kBlue),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         '23',
      //                         style: TextStyle(
      //                             fontSize: 50,
      //                             color: kBlue,
      //                             fontFamily: 'Montserrat_bold'),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 50,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             const SizedBox(
      //               width: 160,
      //               child: Text(
      //                 'Total',
      //                 style: TextStyle(
      //                     fontSize: 25, fontFamily: 'Montserrat_bold'),
      //               ),
      //             ),
      //             const SizedBox(
      //               width: 50,
      //               child: Text(
      //                 '|',
      //                 style: TextStyle(fontSize: 80, color: kBlue),
      //               ),
      //             ),
      //             Column(
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         'Applicants',
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontFamily: 'Montserrat_regular'),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         'Jobs',
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontFamily: 'Montserrat_regular'),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         '5880',
      //                         style: TextStyle(
      //                             fontFamily: 'Montserrat_bold',
      //                             fontSize: 50,
      //                             color: kBlue),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 80,
      //                     ),
      //                     const SizedBox(
      //                       width: 150,
      //                       child: Text(
      //                         '120',
      //                         style: TextStyle(
      //                             fontSize: 50,
      //                             color: kBlue,
      //                             fontFamily: 'Montserrat_bold'),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      //   Container(
      //     margin: EdgeInsets.only(
      //         left: 50, right: MediaQuery.of(context).size.width * 0.5),
      //     child: TextButton(
      //         style: TextButton.styleFrom(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           backgroundColor:
      //               isHovering ? const Color.fromARGB(255, 117, 150, 239) : kBlue,
      //         ),
      //         onPressed: () {
      //           setState(() {});
      //         },
      //         onHover: (value) {
      //           setState(() {
      //             isHovering = value;
      //           });
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             const Text(
      //               'Request for Authentication Mark',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             const Icon(
      //               Icons.check_circle,
      //               color: Colors.white,
      //             )
      //           ],
      //         )),
      //   )
      // ]),
    );
  }
}
