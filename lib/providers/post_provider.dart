import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/job.dart';

class Post {
  final String postID;
  final String jobTitle;
  final String major;
  final String? experienceYears;
  final String location;
  final String? description;
  final String timestamp;

  Post({
    required this.postID,
    required this.jobTitle,
    required this.major,
    required this.location,
    required this.timestamp,
    this.description,
    this.experienceYears,
  });

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future postJob(Job job) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ref = db.collection('posts');
    await ref.add({
      'uid': auth.currentUser!.uid,
      'job_title': job.jobTitle,
      'major': job.major,
      'experience_years': job.yearsOfExperience,
      'city': job.city,
      'descreption': job.descreption,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'active': true
    });
  }

  static Future getPosts() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection('posts');
    List<Job> list = [];
    await ref
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .get()
        .then(
      (doc) {
        final data = doc.docs;
        if (data.isNotEmpty) {
          for (var value in data) {
            list.add(Job(
              id: value.id,
              jobTitle: value['job_title'],
              major: value['major'],
              yearsOfExperience: value['experience_years'],
              city: value['city'],
              descreption: value['descreption'],
              dt: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(value['timestamp'])),
              isActive: value['active'],
            ));
          }
        }

        // print(list[0].city);
      },
      onError: (e) => print(e),
    );
    return list;
  }

  static Future getPost(String id) async {
    final db = FirebaseFirestore.instance;
    late Post post;
    final ref = db.collection('posts').doc(id);
    await ref.get().then((value) {
      if (value.exists) {
        final data = value.data();
        post = Post(
          postID: id,
          jobTitle: data!['job_title'] ?? '',
          major: data['major'] ?? '',
          location: data['city'] ?? '',
          timestamp: data['timestamp'] ?? '',
          description: data['descreption'] ?? '',
          experienceYears: data['experience_years'] ?? '',
        );
      }
    });
    return post;
  }

  // Future<Job?> getPostInfo(id) async {
  //   final ref = db.collection('posts');
  //   Job? job;
  //   await ref.where('uid', isEqualTo: auth.currentUser!.uid).get().then(
  //     (doc) {
  //       final data = doc.docs as Map<String, dynamic>;
  //       if (data.isNotEmpty) {
  //         job = Job(
  //           id: id,
  //           jobTitle: data['job_title'],
  //           major: data['major'],
  //           yearsOfExperience: data['experience_years'],
  //           city: data['city'],
  //           descreption: data['descreption'],
  //           dt: DateTime.fromMillisecondsSinceEpoch(
  //               int.parse(data['timestamp'])),
  //           isActive: data['active'],
  //         );
  //       }
  //     },
  //     onError: (e) => print(e),
  //   );
  //   return job;
  // }

  // Future editJob(Job job) async {
  //   final ref = db.collection('posts');
  //   await ref.doc(ref.id).update({
  //     'uid': auth.currentUser!.uid,
  //     'job_title': job.jobTitle,
  //     'major': job.major,
  //     'experience_years': job.yearsOfExperience,
  //     'city': job.city,
  //     'descreption': job.descreption,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
  //     'active': true
  //   });
  //   notifyListeners();
  // }

  static Future deletePost(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection('posts').doc(id);
    try {
      await ref.delete();
    } catch (e) {
      throw FirebaseException(plugin: e.toString());
    }
  }

  static Future toggleStatus(String? id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    if (id == null) {
      return;
    }
    final ref = db.collection('posts').doc(id);
    Map<String, dynamic> map = {};
    await ref.get().then(
      (value) {
        if (value.exists) {
          map = value.data() as Map<String, dynamic>;
        }
      },
      onError: (e) => print(e),
    );
    if (map['active'] == null) {
      map['active'] = false;
    } else if (map['active']) {
      map['active'] = false;
    } else {
      map['active'] = true;
    }
    print(map);
    await ref.set(map);
  }

  static Future editPost(Job job) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection('posts').doc(job.id);
    await ref.update({
      'job_title': job.jobTitle,
      'major': job.major,
      'experience_years': job.yearsOfExperience,
      'city': job.city,
      'descreption': job.descreption,
    }).onError((error, stackTrace) => print(error));
  }
}
