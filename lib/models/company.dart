import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Company with ChangeNotifier {

  late final String   uid;
  late final String   name;
  late final String   email;
  late final String?  phone;
  late final String?  photoUrl; 
  late final String?  token;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Company(){getCompanyInfo();}

  Future getCompanyInfo({String? uid}) async {
    uid ??= auth.currentUser?.uid;
    if (uid == null) {
      return;
    }
    final ref = db.collection('users').doc(uid);
    ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        this.uid = uid!;
        name = data['name']??'';
        email = data['email']??'';
        phone = data['phone']??'';
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}