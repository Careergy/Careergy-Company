import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:intl/intl.dart';

import './autocomplete_custom_textfield.dart';

import '../models/application.dart';

import '../constants.dart';

class CustomApplicationListTile extends StatelessWidget {
  CustomApplicationListTile(
      {super.key, required this.application, required this.viewApplication});

  Application application;
  Function viewApplication;

  Future getApplicant() async {
    await application.getApplicantInfo();
    await application.getPostInfo();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getApplicant(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CardLoading(
            height: 100,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            margin: EdgeInsets.only(bottom: 10, top: 10),
            cardLoadingTheme: CardLoadingTheme(
                colorOne: Colors.white10, colorTwo: Colors.white24),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: List.filled(
                      2,
                      const BoxShadow(
                          color: Color.fromRGBO(24, 18, 106, 1),
                          blurRadius: 0.8))),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(9.0),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(197, 129, 56, 255),
                  Color.fromARGB(66, 110, 49, 216)
                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: deviceSize.width * 0.09,
                      height: 80,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(141, 111, 103, 164),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.timestamp)))}\n${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.timestamp)))}\n${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.timestamp)))}',
                          style: const TextStyle(color: white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.white12,
                    ),
                    Container(
                      width: deviceSize.width * 0.2,
                      height: 80,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(88, 111, 103, 164),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                              backgroundImage:
                                  application.applicant.photoUrl == null ||
                                          application.applicant.photoUrl!
                                                  .substring(0, 4) !=
                                              'http'
                                      ? null
                                      : NetworkImage(
                                          application.applicant.photoUrl ?? ''),
                              child: application.applicant.photoUrl == null ||
                                      application.applicant.photoUrl!
                                              .substring(0, 4) !=
                                          'http'
                                  ? ClipOval(child: application.applicant.photo)
                                  : null),
                          // CircleAvatar(
                          //   radius: 30,
                          //   backgroundColor:
                          //       const Color.fromARGB(0, 255, 255, 255),
                          //   child: ClipOval(
                          //     child: application.applicant.photoUrl == null ||
                          //             application.applicant.photoUrl!
                          //                     .substring(0, 4) !=
                          //                 'http'
                          //         ? application.applicant.photo
                          //         : Image.network(
                          //             application.applicant.photoUrl ?? '',
                          //             loadingBuilder:
                          //                 (context, child, loadingProgress) {
                          //               if (loadingProgress == null) {
                          //                 return child;
                          //               } else {
                          //                 return const CircularProgressIndicator();
                          //               }
                          //             },
                          //           ),
                          //   ),
                          // ),
                          SizedBox(
                            width: deviceSize.width * 0.2 - 76,
                            height: double.infinity,
                            child: ListTile(
                              title: Text(application.applicant.name ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              textColor: Colors.white,
                              subtitle: Text(application.applicant.bio ?? ''),
                              isThreeLine: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white54),
                    Container(
                      width: deviceSize.width * 0.2,
                      height: 80,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(88, 111, 103, 164),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(
                            '${application.post.jobTitle.toTitleCase()} (${application.post.major.toTitleCase()})',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        textColor: Colors.white,
                        subtitle: Text(
                            '${application.post.location.toTitleCase()} - ${application.post.experienceYears} of experience years'),
                        isThreeLine: false,
                      ),
                    ),
                    Container(
                      width: deviceSize.width * 0.12,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(88, 111, 103, 164),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              application.status.toCapitalized(),
                              style: TextStyle(
                                  color: application.status == 'pending'
                                      ? Colors.white
                                      : application.status == 'waiting'
                                          ? Colors.amber[300]
                                          : application.status == 'accepted'
                                              ? Colors.blue
                                              : application.status == 'approved'
                                                  ? Colors.green
                                                  : Colors.red,
                                  fontSize: 22),
                            ),
                            Text(
                              application.lastUpdated == null
                                  ? '-----'
                                  : '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.lastUpdated ?? '')))} ${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.lastUpdated ?? '')))}\n${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(application.lastUpdated ?? '')))}',
                              style: const TextStyle(color: white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.white12,
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.115,
                      height: 80,
                      child: ActionButtons(
                        application: application,
                        viewApplication: viewApplication,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ActionButtons extends StatefulWidget {
  ActionButtons({
    super.key,
    required this.viewApplication,
    required this.application,
  });

  final Application application;
  final Function viewApplication;

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  double factor = 80;

  Future<void> _showDialog(Application application, String title,
      String subtitle, String button) async {
    bool isLoading = false;
    if (application == null) {
      return;
    }
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: primaryColor,
        title: Text(title,
            style: const TextStyle(
                color: white, fontSize: 14, fontWeight: FontWeight.w800)),
        content: Text(subtitle, style: const TextStyle(color: white)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: white)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(button == 'Reject'
                  ? const Color.fromARGB(255, 165, 29, 19)
                  : const Color.fromARGB(255, 16, 150, 34)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              if (button == 'Reject') {
                await application.changeStatus(newStatus: 'rejected');
              }
              if (button == 'Approve') {
                await application.changeStatus(newStatus: 'approved');
              }
              setState(() {
                isLoading = false;
                Navigator.of(ctx).pop();
              });
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    button,
                    style: const TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    if (DateTime.fromMillisecondsSinceEpoch(int.parse(
                widget.application.appointmentTimestamp ?? '999999999999999'))
            .isBefore(DateTime.now()) &&
        widget.application.status == 'accepted') {
      factor = 35;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        factor == 35
            ? SizedBox(
                width: deviceSize.width * 0.25,
                height: factor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: deviceSize.width * 0.115,
                      height: factor,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 26, 104, 28),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: List.filled(
                              2,
                              const BoxShadow(
                                  color: Colors.black26, blurRadius: 0.2))),
                      child: InkWell(
                        child: const Center(
                          child: Text('Approve',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                        onTap: () async {
                          await _showDialog(widget.application, 'Conformation!',
                              'Confirm approve?', 'Approve');
                        },
                      ),
                    ),
                    Container(
                      width: deviceSize.width * 0.115,
                      height: factor,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 36, 30),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: List.filled(
                              2,
                              const BoxShadow(
                                  color: Colors.black26, blurRadius: 0.2))),
                      child: InkWell(
                        child: const Center(
                          child: Text('Reject',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                        onTap: () async {
                          await _showDialog(widget.application, 'Warning!',
                              'Confirm reject?', 'Reject');
                        },
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        Container(
          width: deviceSize.width * 0.115,
          height: factor,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: List.filled(
                2, const BoxShadow(color: Colors.black26, blurRadius: 0.2)),
          ),
          child: InkWell(
            hoverColor: canvasColor,
            onTap: () {
              widget.viewApplication(context, widget.application);
            },
            child: const Center(
              child: Text('View',
                  style: TextStyle(
                      fontSize: 20, color: white, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ],
    );
  }
}
