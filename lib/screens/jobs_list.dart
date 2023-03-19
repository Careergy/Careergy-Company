import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/models/job.dart';
import 'package:flutter/material.dart';

class jobsList extends StatelessWidget {
  final Job job;
  jobsList({required this.job, required Null Function() onTap});
  @override
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
                "${job.JobID}",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                job.jobTitle,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                job.yearsOfExperience,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                job.major,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                job.city ?? "not specified",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  job.descreption,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
