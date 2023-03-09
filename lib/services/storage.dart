import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_core/firebase_core.dart';

class Storage {
  final FirebaseStorage fs = FirebaseStorage.instance;

  Future uploadFile(String desFplder, Uint8List data, String fileName) async {
    fileName = Timestamp.now().toDate().toString() + fileName;

    try {
      await fs.ref(desFplder + fileName).putData(data);
      return fileName;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future deleteFile(String desFplder, String fileName) async {
    try {
      await fs.ref(desFplder + fileName).delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
