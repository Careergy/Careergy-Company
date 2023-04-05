import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Applicant with ChangeNotifier {
  final String uid;
  late final String name;
  late final String email;
  late final String? phone;
  late final String? photoUrl;
  late String? bio;
  late String? major;
  late Image photo = const Image(image: AssetImage('/avatarPlaceholder.png'));
  late Map<String, dynamic>? briefcv;

  Applicant(
      {required this.uid,
      required this.name,
      required this.email,
      this.phone,
      this.photoUrl,
      this.bio,
      this.major}) {
    getAvatar();
  }

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
        major: data['major'] ?? '',
        photoUrl: id,
      );
    }, onError: (e) => print(e));
    await applicant!.getAvatar();
    final ref2 = db.collection('briefcvs').doc(id);
    await ref2.get().then((value) => applicant!.briefcv = value.data(),
        onError: (e) => print(e));

    return applicant;
  }

  static Future getSearchResults(List<String> jobTitles, List<String> locations,
      List<String> levels) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final List<Applicant> list = [];
    final ref = db.collection('briefcvs');
    final List<String> uids1 = [];
    final List<String> uids2 = [];
    final List<String> uids3 = [];

    if (jobTitles.isNotEmpty) {
      await ref
          .where('job_title', arrayContainsAny: [...jobTitles])
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

    // print(uids1);
    // print(locations);
    // print(levels);

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
          print(doc.get('name').toString());
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
            photoUrl: element,
          );
          list.add(tmp);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }

    print(list);
    return list;
  }

  Future getAvatar() async {
    final imagesRef = fs.child("photos/$photoUrl");
    try {
      print(imagesRef.fullPath);
      const oneMegabyte = 1024 * 512;
      final Uint8List? data = await imagesRef.getData(oneMegabyte);
      final String url = await imagesRef.getDownloadURL();
      print(url);
      // // Data for "images/island.jpg" is returned, use this as needed.
      if (data != null) {
        photo = Image.memory(data);
        return;
      } else {
        photo = Image.network(
          url,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        );
        return;
      }
    } on FirebaseException catch (e) {
      // Handle any errors.
      print('Avatar $e');
    }
  }
}
