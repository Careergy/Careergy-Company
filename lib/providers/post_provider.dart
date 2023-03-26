import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:careergy_mobile/models/job.dart';

class Post with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future postJob(Job job) async {
    final ref = db.collection('posts');
    await ref.add({
      'uid': auth.currentUser!.uid,
      'job_title': job.jobTitle,
      'major': job.major,
      'experience_years': job.yearsOfExperience,
      'city': job.city,
      'descreption': job.descreption,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'active' : true
    });
    notifyListeners();
  }

  Future getPosts() async {
    final ref = db.collection('posts');
    List<Job> list = [];
    await ref
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .orderBy('timestamp')
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

  Future toggleStatus(String? id) async {
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
}