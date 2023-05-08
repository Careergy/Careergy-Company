import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Applicant.dart';

class Application {
  late final String id;
  late final List<String>? attachments;
  late final String status;
  late final Timestamp? timestamp;

  Application(
      {required this.id,
      this.attachments,
      required this.status,
      required this.timestamp});

  getApplicationInfo() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final fs = FirebaseStorage.instance.ref();

    List<Applicant> applicationList = [];
    final ref = db.collection('applications');

    return applicationList;
  }
}
