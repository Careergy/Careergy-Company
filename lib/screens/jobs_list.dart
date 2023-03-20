import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/models/job.dart';
import 'package:flutter/material.dart';

class jobsList extends StatefulWidget {
  final Job job;
  jobsList({required this.job, required Null Function() onTap});

  @override
  State<jobsList> createState() => _jobsListState();
}

class _jobsListState extends State<jobsList> {
  @override
  bool isActivated = true;
  bool isHovering = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: kBlue,
            ),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.centerLeft,
        height: 100,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: Text(
                "${widget.job.JobID}",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                widget.job.jobTitle,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                widget.job.yearsOfExperience,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                widget.job.major,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                widget.job.city ?? "not specified",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.job.descreption,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Container(
                decoration: BoxDecoration(
                    color: isActivated
                        ? (isHovering ? Colors.green.shade400 : Colors.green)
                        : (isHovering ? Colors.red.shade400 : Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  child: isActivated
                      ? Text(
                          "Deactivate",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "Activate",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    setState(() => isActivated = !isActivated);
                  },
                  onHover: (value) {
                    setState(() {
                      isHovering = value;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
