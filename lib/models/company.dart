import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Company with ChangeNotifier {
  late final String uid;
  late final String name;
  late final String email;
  late final String? phone;
  late final String photoUrl;
  late Image? photo;
  late final String? token;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fs = FirebaseStorage.instance.ref();

  Company() {
    getCompanyInfo();
  }

  bool get hasPhoto {
    if (photo == null) {
      return false;
    }else {
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
        print(data);
        this.uid = uid!;
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        phone = data['phone'] ?? '';
        photoUrl = data['photoUrl'] ?? '';
      },
      onError: (e) => print("Error getting document: $e"),
    );
    await getAvatar();
    notifyListeners();
  }

  Future setCompanyInfo(Map<String,dynamic> info) async {
    if (uid == null) {
      return;
    }
    Image img = info["photoUrl"] as Image;
    String imgName = Timestamp.now().toString()+uid+'.jpg';
    info["photoUrl"] = imgName;
    final ref = db.collection('companies').doc(uid);
    await ref.set(info).onError((e, _) => print("Error writing document: $e"));
    final imagesRef = fs.child("photos/$imgName");
    
  }

  Future getAvatar() async {
    final imagesRef = fs.child("photos/$photoUrl");
    try {
      print(imagesRef.fullPath);
      const oneMegabyte = 1024 * 512;
      final Uint8List? data = await imagesRef.getData(oneMegabyte);
      // // Data for "images/island.jpg" is returned, use this as needed.
      photo = Image.memory(data!);
    } on FirebaseException catch (e) {
      // Handle any errors.
      print('Avatar $e');
    }
  }
}
