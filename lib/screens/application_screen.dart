import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import './applicant_profile_screen.dart';
import './jobs_list.dart';

import '../widgets/custom_textfieldform.dart';

import '../providers/meetings_provider.dart';

import '../models/application.dart';

import '../constants.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key, required this.application});

  final Application application;

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  ScrollController? _scrollController;

  final CalendarController _calendarController = CalendarController();
  Appointment? app;
  final List<Appointment> apps = <Appointment>[];
  MeetingDataSource? _events;

  List<Appointment> _getDataSource() {
    final DateTime start = DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.application.appointmentTimestamp ?? '0'));
    final DateTime end = DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.application.appointmentTimestamp ?? '0') + 3600000);
    app = Appointment(
      subject: widget.application.applicant.name ?? '',
      startTime: start,
      endTime: end,
      color: const Color(0xFF0F8644),
      isAllDay: false,
    );
    apps.add(app!);
    // print(app!.startTime.millisecondsSinceEpoch);

    return apps;
  }

  bool _isNew = true;

  bool _acceptIsLoading = false;
  bool _rejectIsLoading = false;
  bool _approveIsLoading = false;
  bool _saveIsLoading = false;

  bool _update = true;

  bool _textChanged = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext contet) {
    final deviceSize = MediaQuery.of(context).size;
    if (widget.application.appointmentTimestamp != null &&
        widget.application.appointmentTimestamp != '' &&
        _isNew) {
      _events = MeetingDataSource(_getDataSource());
      _isNew = false;
    } else {
      _events = MeetingDataSource(apps);
    }
    if (!_textChanged) {
      _addressController.text = widget.application.address ?? '';
      _noteController.text = widget.application.note ?? '';
    }
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
            onPressed: () => Navigator.of(context).pop(_update),
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
                                        width: deviceSize.width * 0.18,
                                        padding: const EdgeInsets.all(18),
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
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller: _scrollController,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: widget
                                                                        .application
                                                                        .applicant
                                                                        .photoUrl ==
                                                                    null ||
                                                                widget.application.applicant.photoUrl!.substring(0, 4) !=
                                                                    'http'
                                                            ? null
                                                            : NetworkImage(widget
                                                                    .application
                                                                    .applicant
                                                                    .photoUrl ??
                                                                ''),
                                                        child: widget.application.applicant.photoUrl ==
                                                                    null ||
                                                                widget
                                                                        .application
                                                                        .applicant
                                                                        .photoUrl!
                                                                        .substring(0, 4) !=
                                                                    'http'
                                                            ? ClipOval(child: widget.application.applicant.photo)
                                                            : null),
                                                    // CircleAvatar(
                                                    //   radius: 30,
                                                    //   backgroundColor:
                                                    //       const Color.fromARGB(
                                                    //           0, 255, 255, 255),
                                                    //   child: ClipOval(
                                                    //     child: widget
                                                    //                     .application
                                                    //                     .applicant
                                                    //                     .photoUrl ==
                                                    //                 null ||
                                                    //             widget
                                                    //                     .application
                                                    //                     .applicant
                                                    //                     .photoUrl!
                                                    //                     .substring(
                                                    //                         0,
                                                    //                         4) !=
                                                    //                 'http'
                                                    //         ? widget.application
                                                    //             .applicant.photo
                                                    //         : Image.network(
                                                    //             widget
                                                    //                     .application
                                                    //                     .applicant
                                                    //                     .photoUrl ??
                                                    //                 '',
                                                    //             loadingBuilder:
                                                    //                 (context,
                                                    //                     child,
                                                    //                     loadingProgress) {
                                                    //               if (loadingProgress ==
                                                    //                   null) {
                                                    //                 return child;
                                                    //               } else {
                                                    //                 return const CircularProgressIndicator();
                                                    //               }
                                                    //             },
                                                    //           ),
                                                    //   ),
                                                    // ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          widget
                                                                  .application
                                                                  .applicant
                                                                  .name ??
                                                              ''.toTitleCase(),
                                                          style: const TextStyle(
                                                              color: white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return ApplicantProfileScreen(
                                                                    applicant: widget
                                                                        .application
                                                                        .applicant,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                const MaterialStatePropertyAll(
                                                                    primaryColor),
                                                            fixedSize:
                                                                MaterialStatePropertyAll(
                                                              Size(
                                                                deviceSize
                                                                        .width *
                                                                    0.1,
                                                                7,
                                                              ),
                                                            ),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              'View Profile'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                divider,
                                                const Text(
                                                  'Email: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  widget.application.applicant
                                                          .email ??
                                                      ''.toTitleCase(),
                                                  style: const TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                const Text(
                                                  'Phone Number: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  widget.application.applicant
                                                          .phone ??
                                                      ''.toTitleCase(),
                                                  style: const TextStyle(
                                                      color: white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: deviceSize.height * 0.28,
                                        width: deviceSize.width * 0.18,
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
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Job Title: ',
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                      widget.application.post
                                                          .jobTitle
                                                          .toTitleCase(),
                                                      style: const TextStyle(
                                                          color: white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Major: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Experience Years: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                    widget.application.post
                                                            .experienceYears ??
                                                        'Not specified'
                                                            .toTitleCase(),
                                                    style: const TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Location: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                    widget.application.post
                                                        .location
                                                        .toTitleCase(),
                                                    style: const TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Contract Type: ',
                                                  style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                    widget.application.post
                                                            .type ??
                                                        ''.toTitleCase(),
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
                                    height: deviceSize.height * 0.30,
                                    padding: const EdgeInsets.only(
                                        top: 14,
                                        right: 18,
                                        left: 18,
                                        bottom: 9),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                        ),
                                        divider,
                                        const SizedBox(height: 4),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Text(
                                                widget.application.post
                                                        .description ??
                                                    'No Desciption.',
                                                style: const TextStyle(
                                                    color: white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: deviceSize.height * 0.75,
                              width: deviceSize.width * 0.37,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: deviceSize.height * 0.05,
                                    child: (widget.application.status ==
                                                'waiting' ||
                                            widget.application.status ==
                                                'accepted')
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _approveIsLoading = true;
                                                  });
                                                  widget.application.address = _addressController.text;
                                                  widget.application.note = _noteController.text;
                                                  await widget.application
                                                      .changeStatus(
                                                          newStatus:
                                                              'approved');
                                                  setState(() {
                                                    _approveIsLoading = false;
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Color.fromARGB(255,
                                                              28, 119, 31)),
                                                  fixedSize:
                                                      MaterialStatePropertyAll(
                                                    Size(
                                                      deviceSize.width * 0.18,
                                                      deviceSize.height * 0.05,
                                                    ),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                child: _approveIsLoading
                                                    ? SizedBox(
                                                        height:
                                                            deviceSize.height *
                                                                0.03,
                                                        width:
                                                            deviceSize.width *
                                                                0.03,
                                                        child:
                                                            const CircularProgressIndicator(
                                                                color: white))
                                                    : const Text('Approve'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _rejectIsLoading = true;
                                                  });
                                                  await widget.application
                                                      .changeStatus(
                                                          newStatus:
                                                              'rejected');
                                                  setState(() {
                                                    _rejectIsLoading = false;
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Color.fromARGB(255,
                                                              124, 21, 21)),
                                                  fixedSize:
                                                      MaterialStatePropertyAll(
                                                    Size(
                                                      deviceSize.width * 0.18,
                                                      deviceSize.height * 0.05,
                                                    ),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                child: _rejectIsLoading
                                                    ? SizedBox(
                                                        height:
                                                            deviceSize.height *
                                                                0.03,
                                                        width:
                                                            deviceSize.width *
                                                                0.03,
                                                        child:
                                                            const CircularProgressIndicator(
                                                                color: white),
                                                      )
                                                    : const Text('Reject'),
                                              ),
                                            ],
                                          )
                                        : widget.application.status == 'pending'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: app == null
                                                        ? null
                                                        : () async {
                                                            setState(() {
                                                              _acceptIsLoading =
                                                                  true;
                                                            });
                                                            widget.application
                                                                    .appointmentTimestamp =
                                                                app!.startTime
                                                                    .millisecondsSinceEpoch
                                                                    .toString();
                                                            widget.application
                                                                    .lastUpdated =
                                                                DateTime.now()
                                                                    .millisecondsSinceEpoch
                                                                    .toString();
                                                            widget.application
                                                                    .status =
                                                                'waiting';
                                                            apps.clear();
                                                            _isNew = true;
                                                            await widget
                                                                .application
                                                                .changeStatus(
                                                                    newStatus:
                                                                        'waiting');
                                                            setState(() {
                                                              _acceptIsLoading =
                                                                  false;
                                                              _update = false;
                                                            });
                                                          },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          const MaterialStatePropertyAll(
                                                              primaryColor),
                                                      fixedSize:
                                                          MaterialStatePropertyAll(
                                                        Size(
                                                          deviceSize.width *
                                                              0.18,
                                                          deviceSize.height *
                                                              0.05,
                                                        ),
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: _acceptIsLoading
                                                        ? SizedBox(
                                                            height: deviceSize
                                                                    .height *
                                                                0.03,
                                                            width: deviceSize
                                                                    .width *
                                                                0.03,
                                                            child:
                                                                const CircularProgressIndicator(
                                                                    color:
                                                                        white))
                                                        : const Text('Accept'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        _rejectIsLoading = true;
                                                      });
                                                      await widget.application
                                                          .changeStatus(
                                                              newStatus:
                                                                  'rejected');
                                                      setState(() {
                                                        _rejectIsLoading =
                                                            false;
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          const MaterialStatePropertyAll(
                                                              Color.fromARGB(
                                                                  255,
                                                                  124,
                                                                  21,
                                                                  21)),
                                                      fixedSize:
                                                          MaterialStatePropertyAll(
                                                        Size(
                                                          deviceSize.width *
                                                              0.18,
                                                          deviceSize.height *
                                                              0.05,
                                                        ),
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: _rejectIsLoading
                                                        ? SizedBox(
                                                            height: deviceSize
                                                                    .height *
                                                                0.03,
                                                            width: deviceSize
                                                                    .width *
                                                                0.03,
                                                            child:
                                                                const CircularProgressIndicator(
                                                                    color:
                                                                        white))
                                                        : const Text('Reject'),
                                                  ),
                                                ],
                                              )
                                            : widget.application.status ==
                                                        'approved' ||
                                                    widget.application.status ==
                                                        'rejected'
                                                ? SizedBox(
                                                    height: deviceSize.height *
                                                        0.05,
                                                    width:
                                                        deviceSize.width * 0.37,
                                                    child: Center(
                                                        child: widget
                                                                    .application
                                                                    .status ==
                                                                'approved'
                                                            ? const Text(
                                                                'This application was approved.',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70))
                                                            : const Text(
                                                                'This application was rejected.',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70))),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            _approveIsLoading =
                                                                true;
                                                          });
                                                          await widget
                                                              .application
                                                              .changeStatus(
                                                                  newStatus:
                                                                      'approved');
                                                          setState(() {
                                                            _approveIsLoading =
                                                                false;
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          });
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              const MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          28,
                                                                          119,
                                                                          31)),
                                                          fixedSize:
                                                              MaterialStatePropertyAll(
                                                            Size(
                                                              deviceSize.width *
                                                                  0.18,
                                                              deviceSize
                                                                      .height *
                                                                  0.05,
                                                            ),
                                                          ),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                        ),
                                                        child: _approveIsLoading
                                                            ? SizedBox(
                                                                height: deviceSize
                                                                        .height *
                                                                    0.03,
                                                                width: deviceSize
                                                                        .width *
                                                                    0.03,
                                                                child: const CircularProgressIndicator(
                                                                    color:
                                                                        white))
                                                            : const Text(
                                                                'Approve'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            _rejectIsLoading =
                                                                true;
                                                          });
                                                          await widget
                                                              .application
                                                              .changeStatus(
                                                                  newStatus:
                                                                      'rejected');
                                                          setState(() {
                                                            _rejectIsLoading =
                                                                false;
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          });
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              const MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          124,
                                                                          21,
                                                                          21)),
                                                          fixedSize:
                                                              MaterialStatePropertyAll(
                                                            Size(
                                                              deviceSize.width *
                                                                  0.18,
                                                              deviceSize
                                                                      .height *
                                                                  0.05,
                                                            ),
                                                          ),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                        ),
                                                        child: _rejectIsLoading
                                                            ? SizedBox(
                                                                height: deviceSize
                                                                        .height *
                                                                    0.03,
                                                                width: deviceSize
                                                                        .width *
                                                                    0.03,
                                                                child: const CircularProgressIndicator(
                                                                    color:
                                                                        white))
                                                            : const Text(
                                                                'Reject'),
                                                      ),
                                                    ],
                                                  ),
                                  ),
                                  Container(
                                    height: deviceSize.height * 0.35,
                                    width: deviceSize.width * 0.37,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: SfCalendarTheme(
                                      data: SfCalendarThemeData(
                                        backgroundColor: white,
                                      ),
                                      child: SfCalendar(
                                        view: CalendarView.workWeek,
                                        // allowViewNavigation: true,
                                        showNavigationArrow: true,
                                        // showDatePickerButton: true,

                                        firstDayOfWeek: DateTime.now().weekday,
                                        initialDisplayDate: app?.startTime,
                                        allowDragAndDrop: false,
                                        allowAppointmentResize: false,
                                        timeSlotViewSettings:
                                            const TimeSlotViewSettings(
                                                startHour: 6,
                                                endHour: 18,
                                                nonWorkingDays: <int>[
                                              DateTime.friday,
                                              DateTime.saturday
                                            ]),
                                        dataSource: _events,
                                        controller: _calendarController,
                                        onTap: (calendarTapDetails) {
                                          if (widget.application.status ==
                                                  'accepted' &&
                                              int.parse(widget.application
                                                          .appointmentTimestamp ??
                                                      '') <
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch) {
                                            return;
                                          }
                                          if (app == null) {
                                            app = Appointment(
                                                startTime: _calendarController
                                                    .selectedDate!,
                                                endTime: _calendarController
                                                    .selectedDate!
                                                    .add(const Duration(
                                                        minutes: 60)),
                                                subject: 'Selected!',
                                                color: primaryColor);
                                            _events?.appointments!.add(app);
                                            _events?.notifyListeners(
                                                CalendarDataSourceAction.add,
                                                <Appointment>[app!]);
                                          } else {
                                            app?.startTime =
                                                calendarTapDetails.date!;
                                            app?.endTime = calendarTapDetails
                                                .date!
                                                .add(const Duration(
                                                    minutes: 60));
                                            _events?.notifyListeners(
                                                CalendarDataSourceAction.reset,
                                                <Appointment>[app!]);
                                          }
                                          setState(() {});
                                        },
                                        // onSelectionChanged:
                                        //     (calendarSelectionDetails) {
                                        //   // print('change');
                                        //   _events?.notifyListeners(
                                        //       CalendarDataSourceAction.reset,
                                        //       <Appointment>[app!]);
                                        //   setState(() {});
                                        // },
                                        // onAppointmentResizeEnd:
                                        //     (appointmentResizeEndDetails) {
                                        //   app?.startTime =
                                        //       appointmentResizeEndDetails
                                        //           .startTime!;
                                        //   app?.endTime =
                                        //       appointmentResizeEndDetails
                                        //           .endTime!;
                                        //           print(appointmentResizeEndDetails.endTime!.millisecondsSinceEpoch);
                                        //   _events?.notifyListeners(
                                        //       CalendarDataSourceAction.reset,
                                        //       <Appointment>[app!]);
                                        //   // setState(() {});
                                        // },
                                        // onDragEnd: (appointmentDragEndDetails) {
                                        //   app = appointmentDragEndDetails
                                        //       .appointment as Appointment?;
                                        //   // setState(() {});
                                        // },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: deviceSize.height * 0.27,
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 18, left: 18, bottom: 5),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Address:',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                        ),
                                        divider,
                                        const SizedBox(height: 4),
                                        TextField(
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: titleBackground,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                          style: const TextStyle(color: white),
                                          controller: _addressController,
                                          onChanged: (value) {
                                            setState(() {
                                              _textChanged = true;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Notes:',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                        ),
                                        divider,
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          height: deviceSize.height * 0.12,
                                          child: TextField(
                                            decoration: const InputDecoration(
                                                filled: true,
                                                fillColor: titleBackground,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)))),
                                            style:
                                                const TextStyle(color: white),
                                            controller: _noteController,
                                            maxLines: 15,
                                            onChanged: (value) {
                                              setState(() {
                                                _textChanged = true;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: widget.application.status ==
                                                'waiting' ||
                                            widget.application.status ==
                                                'refused' ||
                                            (widget.application.status ==
                                                    'accepted' &&
                                                int.parse(widget.application
                                                            .appointmentTimestamp ??
                                                        '') >
                                                    DateTime.now()
                                                        .millisecondsSinceEpoch)
                                        ? [
                                            Container(
                                              height: deviceSize.height * 0.05,
                                              width: deviceSize.width * 0.26,
                                              decoration: const BoxDecoration(
                                                  color: titleBackground,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Center(
                                                  child: Text(
                                                app == null
                                                    ? 'Not Selected!'
                                                    : 'Starts:\t${DateFormat.yMMMMd().format(app!.startTime)}  ${DateFormat.jms().format(app!.startTime)}\nEnds:\t\t${DateFormat.yMMMMd().format(app!.endTime)}  ${DateFormat.jms().format(app!.endTime)}',
                                                style: const TextStyle(
                                                    color: white),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                            ElevatedButton(
                                              onPressed: (app == null ||
                                                          (int.parse(widget
                                                                      .application
                                                                      .appointmentTimestamp ??
                                                                  '0') ==
                                                              app?.startTime
                                                                  .millisecondsSinceEpoch)) &&
                                                      !_textChanged
                                                  ? null
                                                  : () async {
                                                      setState(() {
                                                        _saveIsLoading = true;
                                                      });
                                                      widget.application
                                                              .appointmentTimestamp =
                                                          app!.startTime
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      widget.application
                                                              .address =
                                                          _addressController
                                                              .text;
                                                      widget.application.note =
                                                          _noteController.text;
                                                      _update = false;
                                                      await widget.application
                                                          .changeStatus(
                                                              newStatus:
                                                                  'waiting');
                                                      setState(() {
                                                        _saveIsLoading = false;
                                                      });
                                                    },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        primaryColor),
                                                fixedSize:
                                                    MaterialStatePropertyAll(
                                                  Size(
                                                    deviceSize.width * 0.1,
                                                    deviceSize.height * 0.05,
                                                  ),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: _saveIsLoading
                                                  ? SizedBox(
                                                      height:
                                                          deviceSize.height *
                                                              0.03,
                                                      width: deviceSize.width *
                                                          0.03,
                                                      child:
                                                          const CircularProgressIndicator(
                                                              color: white))
                                                  : const Text('Save'),
                                            ),
                                          ]
                                        : [
                                            Container(
                                              height: deviceSize.height * 0.05,
                                              width: deviceSize.width * 0.37,
                                              decoration: const BoxDecoration(
                                                  color: titleBackground,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Center(
                                                  child: Text(
                                                app == null
                                                    ? 'Not Selected!'
                                                    : 'Starts:\t${DateFormat.yMMMMd().format(app!.startTime)}  ${DateFormat.jms().format(app!.startTime)}\nEnds:\t\t${DateFormat.yMMMMd().format(app!.endTime)}  ${DateFormat.jms().format(app!.endTime)}',
                                                style: const TextStyle(
                                                    color: white),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ],
                                  ),
                                ],
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
