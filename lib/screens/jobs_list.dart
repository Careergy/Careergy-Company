import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/post_provider.dart';

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

  Future<void> _deleteConfirm(String? id) async {
    bool isLoading = false;
    if (id == null) {
      return;
    }
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: primaryColor,
        title: const Text('Warning!',
            style: TextStyle(
                color: white, fontSize: 14, fontWeight: FontWeight.w800)),
        content: const Text('Confirm Delete?', style: TextStyle(color: white)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: white)),
          ),
          ElevatedButton(
           style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 165, 29, 19)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Post.deletePost(id);
              setState(() {
                isLoading = false;
                Navigator.of(ctx).pop();
              });
              widget.refresh();
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 16, color: white, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 30,
                child: Text(
                  widget.job.yearsOfExperience,
                  style: const TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  widget.job.major.toTitleCase(),
                  style: const TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.w800),
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
                      fontSize: 16, color: white, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    widget.job.descreption.length > MAX_CHARS
                        ? widget.job.descreption.substring(0, 80) +
                            " ..show more"
                        : widget.job.descreption,
                    style: const TextStyle(fontSize: 15, color: white),
                  ),
                ),
              ),
              SizedBox(
                width: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 0.5,
                      color: Colors.white24,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            // padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                              widget.job.isActive
                                  ? const Color.fromARGB(255, 0, 109, 27)
                                  : const Color.fromARGB(255, 109, 0, 0),
                            ), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return actionColor; // <-- Splash color
                                }
                              },
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: white)
                              : const Icon(Icons.power_settings_new_rounded),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await Post.toggleStatus(widget.job.id);
                            setState(() {
                              isLoading = false;
                              widget.job.isActive = !widget.job.isActive;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              isHovering = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          width: 70,
                          decoration: BoxDecoration(
                              color: widget.job.isActive
                                  ? const Color.fromARGB(255, 0, 109, 27)
                                  : const Color.fromARGB(255, 109, 0, 0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: widget.job.isActive
                                ? const Text('Active',
                                    style: TextStyle(color: white))
                                : const Text('Inactive',
                                    style: TextStyle(color: white)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: deleteIsLoading
                            ? const CircularProgressIndicator()
                            : const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                        onPressed: () async {
                          await _deleteConfirm(widget.job.id);
                        },
                        onHover: (value) {
                          setState(() {
                            deleteIsHovering = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
