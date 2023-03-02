import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User with ChangeNotifier {
  late final String uid;
  late final String name;
  late final String email;
  late final String? phone;
  late final String? photoUrl;
  late final String? token;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // User({required this.uid, required this.fname, required this.lname, required this.email, this.phone, this.photoUrl, this.token});

  // Future<Map<String, String>> getUserInfo(String uid) async {
  //   final Map<String, String> user = {'id': '', 'name': '', 'email': ''};
  //   final ref = db.collection('users').doc(uid);
  //   await ref.get().then(
  //     (DocumentSnapshot doc) {
  //       user['id'] = uid;
  //       user['name'] = doc.get('name').toString();
  //       user['email'] = doc.get('email').toString();
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  //   print(user);
  //   return user;
  // }

  Future getSearchResults(List<String> job_titles, List<String> locations,
      List<String> levels) async {
    final List<Map<String, String>> list = [];
    final ref = db.collection('briefcvs');
    final List<String> uids1 = [];
    final List<String> uids2 = [];
    final List<String> uids3 = [];

    if (job_titles.isNotEmpty) {
      await ref
          .where('job_title', arrayContainsAny: [...job_titles])
          // .where('level', arrayContainsAny: ['',...levels])
          // .where('location', arrayContainsAny: ['',...locations])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              if (!uids1.contains(value.docs[i].id)) {
                uids1.add(value.docs[i].id);
              }
            }
          })
          .catchError((err) => print(err));
    }

    if (levels.isNotEmpty) {
      await ref
          // .where('job_title', arrayContainsAny: ['', ...job_titles])
          .where('level', arrayContainsAny: [...levels])
          // .where('location', arrayContainsAny: ['',...locations])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              if (!uids2.contains(value.docs[i].id)) {
                uids2.add(value.docs[i].id);
              }
            }
          })
          .catchError((err) => print(err));
    }

    if (locations.isNotEmpty) {
      await ref
          // .where('job_title', arrayContainsAny: ['', ...job_titles])
          // .where('level', arrayContainsAny: ['',...levels])
          .where('location', arrayContainsAny: [...locations])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              if (!uids3.contains(value.docs[i].id)) {
                uids3.add(value.docs[i].id);
              }
            }
          })
          .catchError((err) => print(err));
    }

    print(uids1);
    print(locations);
    print(levels);

    if (levels.isNotEmpty) {
      uids1.removeWhere((element) => !uids2.contains(element));
    }
    if (locations.isNotEmpty) {
      uids1.removeWhere((element) => !uids3.contains(element));
    }

    final ref2 = db.collection('users');
    for (var element in uids1) {
      await ref2.doc(element).get().then(
        (DocumentSnapshot doc) {
          list.add({
            'id': element,
            'name': doc.get('name').toString(),
            'email': doc.get('email').toString()
          });
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }

    print(list);
    return list;
  }
}
