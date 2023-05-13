import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/job.dart';

import '../constants.dart';

class JobsList extends StatefulWidget {
  final Job job;
  final Function refresh;
  final Function editingPage;

  JobsList({
    required this.job,
    required this.refresh,
    required this.editingPage,
  });

  @override
  State<JobsList> createState() => _JobsListState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _JobsListState extends State<JobsList> {
  @override
  _JobsListState();

  bool isHovering = false;
  int MAX_CHARS = 80;
  bool isLoading = false;
  bool deleteIsLoading = false;
  bool deleteIsHovering = false;

  @override
  Widget build(BuildContext context) {
    if (widget.job.isActive) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () async {
            await widget.editingPage(widget.job);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(197, 129, 56, 255),
                  Color.fromARGB(66, 110, 49, 216)
                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
            // alignment: Alignment.centerLeft,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    '${DateFormat.yMMMMd().format(widget.job.dt!)}\n${DateFormat.EEEE().format(widget.job.dt!)}\n${DateFormat.jms().format(widget.job.dt!)}',
                    style: const TextStyle(fontSize: 15, color: white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.job.jobTitle.toTitleCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    widget.job.major.toTitleCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    widget.job.city != ''
                        ? widget.job.city.toTitleCase()
                        : "Not Specified",
                    style: const TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }
}
