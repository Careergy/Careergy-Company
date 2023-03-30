import 'dart:typed_data';
import 'dart:ui';

import 'package:careergy_mobile/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Company with ChangeNotifier {
  late final String uid;
  late String name;
  late String email;
  late String? phone;
  late String photoUrl;
  Image photo = const Image(image: AssetImage('/avatarPlaceholder.png'));
  late String bio;
  late String? token;

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
        print(data);
        this.uid = uid!;
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        phone = data['phone'] ?? '';
        photoUrl = data['photoUrl'] ?? '';
        bio = data['bio']??'';
      },
      onError: (e) => print("Error getting document: $e"),
    );
    await getAvatar();
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
        'bio' : info['bio']??'',
        'photoUrl': photoUrl,
      }).onError((e, _) => print("Error writing document: $e"));
      name = info['name'];
      email = info['email'];
      phone = info['phone'];
      bio = info['bio']??'';
      notifyListeners();
      return;
    }

    await ref.set({
      'name': info['name'],
      'email': info['email'],
      'phone': info['phone'],
      'photoUrl': info['photoUrl']['fileName'],
    }).onError((e, _) => print("Error writing document: $e"));
    final String fileName = await Storage()
        .uploadFile(
            'photos/', info['photoUrl']['bytes'], info['photoUrl']['fileName'])
        .onError((error, stackTrace) => print(error));
    await Storage().deleteFile('photos/', photoUrl);
    await ref.set({
      'name': info['name'],
      'email': info['email'],
      'phone': info['phone'],
      'photoUrl': fileName,
    }).onError((e, _) => print("Error writing document: $e"));
    name = info['name'];
    email = info['email'];
    phone = info['phone'];
    photoUrl = fileName;
    await getAvatar();
    notifyListeners();
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
