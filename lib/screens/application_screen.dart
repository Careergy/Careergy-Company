import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './jobs_list.dart';

import '../models/application.dart';

import '../constants.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key, required this.application});

  final Application application;

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: accentCanvasColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor:
                  MaterialStateProperty.all(primaryColor), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return actionColor; // <-- Splash color
                  }
                },
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
                child: Center(
                    child: Text(widget.application.applicant.name ?? '- - - - ',
                        style: const TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ))),
              ),
              const SizedBox(height: 8),
              divider,
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: deviceSize.height * 0.75,
                              width: deviceSize.width * 0.37,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: deviceSize.height * 0.13,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 2.0),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(197, 129, 56, 255),
                                            Color.fromARGB(66, 110, 49, 216)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Application Date:',
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16)),
                                            Text(
                                              widget.application.timestamp ==
                                                      null
                                                  ? '- - - - -'
                                                  : '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.timestamp)))} ${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.timestamp)))} ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.timestamp)))}',
                                              style: const TextStyle(
                                                  color: Colors.white54),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('Status:',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 16)),
                                                const SizedBox(width: 5),
                                                Text(
                                                  widget.application.status
                                                      .toCapitalized(),
                                                  style: TextStyle(
                                                      color: widget.application
                                                                  .status ==
                                                              'pending'
                                                          ? Colors.white
                                                          : widget.application
                                                                      .status ==
                                                                  'waiting'
                                                              ? Colors
                                                                  .amber[300]
                                                              : widget.application
                                                                          .status ==
                                                                      'accepted'
                                                                  ? Colors.blue
                                                                  : widget.application
                                                                              .status ==
                                                                          'approved'
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              widget.application.lastUpdated ==
                                                      null
                                                  ? 'Last Updated: - - - - -'
                                                  : 'Last Updated: ${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.lastUpdated ?? '')))} ${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.lastUpdated ?? '')))} ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.application.lastUpdated ?? '')))}',
                                              style: const TextStyle(
                                                  color: Colors.white54),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          widget.application.status == 'pending'
                                              ? 'The applicant is waiting for your response.'
                                              : widget.application.status ==
                                                      'waiting'
                                                  ? 'Waiting for the applicant response upon the appointment.'
                                                  : widget.application.status ==
                                                          'accepted'
                                                      ? 'The applicant has accepted the date and time of the appointment.'
                                                      : widget.application
                                                                  .status ==
                                                              'approved'
                                                          ? 'The applicant is approved and joined the company.'
                                                          : 'The applicant was rejected.',
                                          style: const TextStyle(color: white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: deviceSize.height * 0.28,
                                        width: deviceSize.width*0.17,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 2.0),
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    197, 129, 56, 255),
                                                Color.fromARGB(66, 110, 49, 216)
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(children: [
                                              const Text('Job Title: ',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16)),
                                              Text(
                                                  widget
                                                      .application.post.jobTitle
                                                      .toTitleCase(),
                                                  style: const TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ]),
                                            Row(
                                              children: [
                                                const Text('Major: ',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 16)),
                                                Text(
                                                    widget
                                                        .application.post.major
                                                        .toTitleCase(),
                                                    style: const TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: deviceSize.height * 0.28,
                                        width: deviceSize.width*0.17,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 2.0),
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    197, 129, 56, 255),
                                                Color.fromARGB(66, 110, 49, 216)
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(children: [
                                              const Text('Job Title: ',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16)),
                                              Text(
                                                  widget
                                                      .application.post.jobTitle
                                                      .toTitleCase(),
                                                  style: const TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ]),
                                            Row(
                                              children: [
                                                const Text('Major: ',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 16)),
                                                Text(
                                                    widget
                                                        .application.post.major
                                                        .toTitleCase(),
                                                    style: const TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: deviceSize.height * 0.28,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(197, 129, 56, 255),
                                            Color.fromARGB(66, 110, 49, 216)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: deviceSize.height * 0.75,
                              width: deviceSize.width * 0.37,
                              decoration: const BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
