import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './applicant.dart';
import '../providers/post_provider.dart';

class Application {
  final String id;
  final String applicantId;
  final String companyId;
  final String postId;
  String status;
  final String timestamp;
  String? appointmentTimestamp;
  String? lastUpdated;

  late Applicant applicant;
  late Post post;

  final db = FirebaseFirestore.instance;

  Application({
    required this.id,
    required this.applicantId,
    required this.companyId,
    required this.postId,
    required this.timestamp,
    required this.status,
    this.appointmentTimestamp,
    this.lastUpdated,
  });

  Future getApplicantInfo() async {
    applicant = await Applicant.getApplicantInfo(applicantId);
  }

  Future getPostInfo() async {
    post = await Post.getPost(postId);
  }

  Future changeStatus(String newStatus) async {
    final ref = db.collection('applications').doc(id);
    final updateTime = DateTime.now();
    await ref.set({
      'status': newStatus,
      'last_updated': updateTime.millisecondsSinceEpoch
    }, SetOptions(merge: true));
  }
}