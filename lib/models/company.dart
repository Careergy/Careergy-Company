import 'dart:typed_data';
import 'dart:ui';

import '../services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './application.dart';

class Company with ChangeNotifier {
  late final String uid;
  String? name;
  String? email;
  String? phone;
  String? photoUrl;
  Image photo = const Image(image: AssetImage('/avatarPlaceholder.png'));
  String? bio;
  late String? token;

  List<Application>? applications;
  List<Application>? oldApplications;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fs = FirebaseStorage.instance.ref();

  Company() {
    getCompanyInfo();
  }

  bool get hasPhoto {
    if (photo == null) {
      return false;
    } else {
      return true;
    }
  }

  Future getCompanyInfo({String? uid}) async {
    uid ??= auth.currentUser?.uid;
    if (uid == null) {
      return;
    }
    final ref = db.collection('companies').doc(uid);
    await ref.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;
        // print(data);
        this.uid = uid!;
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        phone = data['phone'] ?? '';
        photoUrl = data['photoUrl'] ?? '';
        bio = data['bio'] ?? '';
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // await getAvatar();
    notifyListeners();
  }

  Future setCompanyInfo(Map<String, dynamic> info) async {
    if (uid == null) {
      return;
    }

    final ref = db.collection('companies').doc(uid);

    if (info['photoUrl'] == null) {
      await ref.set({
        'name': info['name'],
        'email': info['email'],
        'phone': info['phone'],
        'bio': info['bio'] ?? '',
        'photoUrl': photoUrl,
      }).onError((e, _) => print("Error writing document: $e"));
      name = info['name'];
      email = info['email'];
      phone = info['phone'];
      bio = info['bio'] ?? '';
      notifyListeners();
      return;
    }

    await Storage()
        .uploadFile('photos/', info['photoUrl']['bytes'], uid)
        .onError((error, stackTrace) => print(error));
    // await Storage().deleteFile('photos/', photoUrl);
    photoUrl = await fs.child('photos/$uid').getDownloadURL();
    await ref.set({
      'photoUrl': photoUrl,
    }, SetOptions(merge: true)).onError(
        (e, _) => print("Error writing document: $e"));

    await ref.set({
      'name': info['name'],
      'email': info['email'],
      'phone': info['phone'],
      'bio': info['bio'] ?? '',
      'photoUrl': info['photoUrl']['fileName'],
    }).onError((e, _) => print("Error writing document: $e"));

    name = info['name'];
    email = info['email'];
    phone = info['phone'];
    // photoUrl = fileName;
    bio = info['bio'] ?? '';
    // await getAvatar();
    notifyListeners();
  }

  // Future getAvatar() async {
  //   final imagesRef = fs.child("photos/$photoUrl");
  //   try {
  //     print(imagesRef.fullPath);
  //     const oneMegabyte = 1024 * 512;
  //     final Uint8List? data = await imagesRef.getData(oneMegabyte);
  //     // // Data for "images/island.jpg" is returned, use this as needed.
  //     photo = Image.memory(data!);
  //   } on FirebaseException catch (e) {
  //     // Handle any errors.
  //     print('Avatar $e');
  //   }
  // }

  Future getApplications({String? uid}) async {
    List<Application> applications = [];
    final db = FirebaseFirestore.instance;
    final ref = db.collection('applications');
    // print('--------------------------');
    await ref
        .where('company_uid', isEqualTo: this.uid)
        .where('status', whereIn: ['pending', 'accepted', 'waiting', 'new'])
        .orderBy('timestamp')
        .get()
        .then(
          (value) {
            if (value.docs.isNotEmpty) {
              for (var doc in value.docs) {
                var data = doc.data();
                // print(data);
                Application ap = Application(
                  id: doc.id,
                  applicantId: doc.data().toString().contains('applicant_uid')
                ? doc.get('applicant_uid').toString()
                : '',
                  companyId: doc.data().toString().contains('company_uid')
                ? doc.get('company_uid').toString()
                : '',
                  postId: doc.data().toString().contains('post_uid')
                ? doc.get('post_uid').toString()
                : '',
                  timestamp: doc.data().toString().contains('timestamp')
                ? doc.get('timestamp').toString()
                : '',
                  status: doc.data().toString().contains('status')
                ? doc.get('status').toString()
                : 'pending',
                  appointmentTimestamp: doc.data().toString().contains('appointment_timestamp')
                ? doc.get('appointment_timestamp').toString()
                : null,
                );
                // print(ap.applicantId);
                applications.add(ap);
              }
            }
          },
          onError: (e) => print(e),
        );
    // print(applications[0].applicantId);
    return applications;
  }
}
