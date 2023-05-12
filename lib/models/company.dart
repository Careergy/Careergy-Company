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
  String? address;
  String? photoName;
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
        photoUrl = data['photoUrl'];
        address = data['address'] ?? '';
        bio = data['bio'] ?? '';
        photoName = data['photoName'] ?? '';
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // await getAvatar();
    print('getCompany');
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
        'address': info['address'],
        'photoName': photoName,
        'photoUrl': photoUrl,
      }).onError((e, _) => print("Error writing document: $e"));
      name = info['name'];
      email = info['email'];
      phone = info['phone'];
      address = info['address'];
      bio = info['bio'] ?? '';
      notifyListeners();
      return;
    }
    var temp;
    await Storage().uploadFile('photos/', info['photoUrl']['bytes'], uid).then(
        (value) => temp = value.toString(),
        onError: (error) => print(error));
    if (photoUrl != null) {
      await Storage().deleteFile('photos/', photoName ?? '');
    }
    photoUrl = await fs.child('photos/$temp').getDownloadURL();
    // await ref.set({
    //   'photoUrl': photoUrl,
    // }, SetOptions(merge: true)).onError(
    //     (e, _) => print("Error writing document: $e"));

    await ref.set({
      'name': info['name'],
      'email': info['email'],
      'phone': info['phone'],
      'address': info['address'],
      'bio': info['bio'] ?? '',
      'photoUrl': photoUrl,
      'photoName' : temp,
    }).onError((e, _) => print("Error writing document: $e"));

    name = info['name'];
    email = info['email'];
    phone = info['phone'];
    address = info['address'];
    bio = info['bio'] ?? '';
    photoName = temp;
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
    final ref = db.collection('applications');
    await ref
        .where('company_uid', isEqualTo: this.uid)
        .where('status', whereIn: ['pending', 'accepted', 'waiting', 'new'])
        .orderBy('timestamp', descending: true)
        .get()
        .then(
          (value) {
            if (value.docs.isNotEmpty) {
              for (var doc in value.docs) {
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
                  appointmentTimestamp:
                      doc.data().toString().contains('appointment_timestamp')
                          ? doc.get('appointment_timestamp').toString()
                          : null,
                  lastUpdated: doc.data().toString().contains('last_updated')
                      ? doc.get('last_updated').toString()
                      : null,
                );
                applications.add(ap);
              }
            }
          },
          onError: (e) => print(e),
        );
        print('getApplications');
    return applications;
  }

  Future getApplicationsHistory({String? uid}) async {
    List<Application> applications = [];
    final ref = db.collection('applications');
    await ref
        .where('company_uid', isEqualTo: this.uid)
        .where('status', whereIn: ['approved', 'rejected'])
        .orderBy('timestamp')
        .get()
        .then(
          (value) {
            if (value.docs.isNotEmpty) {
              for (var doc in value.docs) {
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
                  appointmentTimestamp:
                      doc.data().toString().contains('appointment_timestamp')
                          ? doc.get('appointment_timestamp').toString()
                          : null,
                  lastUpdated: doc.data().toString().contains('last_updated')
                      ? doc.get('last_updated').toString()
                      : null,
                );
                applications.add(ap);
              }
            }
          },
          onError: (e) => print(e),
        );
        print('getHistory');
    return applications;
  }
}
