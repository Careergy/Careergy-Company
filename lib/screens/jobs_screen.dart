import 'package:careergy_mobile/widgets/jobsList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:careergy_mobile/screens/post_job_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState('/jobs');
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  final List posts = [];

  String? currentPage;
  _JobsScreenState(this.currentPage);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jobs'),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, Index) {
            return jobsList(
              child: posts[Index],
            );
          }),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostJob()),
          );
        },
        child: const Text(
          'Post New',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
