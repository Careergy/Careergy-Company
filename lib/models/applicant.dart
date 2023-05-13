import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Applicant with ChangeNotifier {
  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? bio;
  final String? address;
  Image photo = const Image(image: AssetImage('/avatarPlaceholder.png'));
  Map<String, List?>? briefcv;

  Applicant({
    required this.uid,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.bio,
    this.address,
  });

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final fs = FirebaseStorage.instance.ref();

  static Future getApplicantInfo(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection('users').doc(id);
    Applicant? applicant;
    await ref.get().then((value) {
      final data = value.data();
      applicant = Applicant(
        uid: id,
        name: data!['name'] ?? '',
        email: data['email'] ?? '',
        bio: data['bio'] ?? '',
        phone: data['phone'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
        address: data['address'] ?? '',
      );
    }, onError: (e) => print(e));
    // final ref2 = db.collection('briefcvs').doc(id);
    // await ref2
    //     .get()
    //     .then((value) {
    //       if (value.exists) {
    //         final data = value.data();
    //         applicant!.briefcv = {
    //           'job_title' : data!['job_title']??[],
    //           'majors' : data['majors']??[],
    //           'major_skills' : data['major_skills']??[],
    //           'soft_skills' : data['soft_skills']??[],
    //           'intrests' : data['intrests']??[],
    //           'prefered_locations' : data['prefered_locations']??[],
    //           'other_skills' : data['other_skills']??[],
    //         };
    //       }
    //       applicant!.briefcv = null;
    //     }, onError: (e) => applicant!.briefcv = null);

    // print(applicant!.briefcv!['job_title']);
    print('getApplicant');
    return applicant;
  }

  static Future getBriefCV(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection('briefcvs').doc(id);
    Map<String, List?>? briefcv;
    await ref.get().then((value) {
      if (value.exists) {
        final data = value.data();
        briefcv = {
          'job_title': data!['job_title'] ?? [],
          'majors': data['majors'] ?? [],
          'major_skills': data['major_skills'] ?? [],
          'soft_skills': data['soft_skills'] ?? [],
          'intrests': data['intrests'] ?? [],
          'prefered_locations': data['prefered_locations'] ?? [],
          'other_skills': data['other_skills'] ?? [],
        };
      }
    }, onError: (e) => print(e));
    print('getBrief');
    return briefcv;
  }

  static Future getSearchResults(
      List<String>? majors,
      List<String>? jobTitles,
      List<String>? majorSkills,
      List<String>? softSkills,
      List<String>? interests,
      List<String>? locations) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final List<String> list = [];
    final ref = db.collection('briefcvs');

    final majorsRes =
        await ref.where('majors', arrayContainsAny: ['', ...?majors]).get();
    final jobTitRes = await ref
        .where('job_title', arrayContainsAny: ['', ...?jobTitles]).get();
    final majSkiRes = await ref
        .where('major_skills', arrayContainsAny: ['', ...?majorSkills]).get();
    final sofSkiRes = await ref
        .where('soft_skills', arrayContainsAny: ['', ...?softSkills]).get();
    final intresRes = await ref
        .where('intrests', arrayContainsAny: ['', ...?interests]).get();
    final preLocRes = await ref.where('prefered_locations',
        arrayContainsAny: ['', ...?locations]).get();

    List list1 = [];
    majorsRes.docs.forEach((el) => list1.add(el.id));
    List list2 = [];
    jobTitRes.docs.forEach((el) => list2.add(el.id));
    List list3 = [];
    majSkiRes.docs.forEach((el) => list3.add(el.id));
    List list4 = [];
    sofSkiRes.docs.forEach((el) => list4.add(el.id));
    List list5 = [];
    intresRes.docs.forEach((el) => list5.add(el.id));
    List list6 = [];
    preLocRes.docs.forEach((el) => list6.add(el.id));

    if (list2.isNotEmpty) {
      list1.addAll(list2.where((element) => !list1.contains(element)));
    }
    if (list3.isNotEmpty) {
      list1.addAll(list3.where((element) => !list1.contains(element)));
    }
    if (list4.isNotEmpty) {
      list1.addAll(list4.where((element) => !list1.contains(element)));
    }
    if (list5.isNotEmpty) {
      list1.addAll(list5.where((element) => !list1.contains(element)));
    }
    if (list6.isNotEmpty) {
      list1.addAll(list6.where((element) => !list1.contains(element)));
    }

    if (list2.isNotEmpty) {
      list1.removeWhere((element) => !list2.contains(element));
    }
    if (list3.isNotEmpty) {
      list1.removeWhere((element) => !list3.contains(element));
    }
    if (list4.isNotEmpty) {
      list1.removeWhere((element) => !list4.contains(element));
    }
    if (list5.isNotEmpty) {
      list1.removeWhere((element) => !list5.contains(element));
    }
    if (list6.isNotEmpty) {
      list1.removeWhere((element) => !list6.contains(element));
    }

    // print(list1);
    // print(list2);
    // print(list3);
    // print(list4);
    // print(list5);
    // print(list6);

    List<Applicant> applicantList = [];
    final ref2 = db.collection('users');
    for (var element in list1) {
      await ref2.doc(element).get().then(
        (DocumentSnapshot doc) {
          // print(doc.get('name').toString());
          Applicant tmp = Applicant(
            uid: element,
            email: doc.data().toString().contains('email')
                ? doc.get('email').toString()
                : '',
            name: doc.data().toString().contains('name')
                ? doc.get('name').toString()
                : '',
            phone: doc.data().toString().contains('phone')
                ? doc.get('phone').toString()
                : '',
            bio: doc.data().toString().contains('bio')
                ? doc.get('bio').toString()
                : '',
            photoUrl: doc.data().toString().contains('photoUrl')
                ? doc.get('photoUrl').toString()
                : '',
          );
          applicantList.add(tmp);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
    print('getSearchresult');
    return applicantList;
  }
}
