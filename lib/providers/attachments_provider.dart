import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AttachmentsProvider {

  final fs = FirebaseStorage.instance.ref();

  Future getAttachmentsUrl(String folder, String uid, List<String> list) async {
    List<String> urlList = [];
    for (var element in list) {
      final url = await fs.child('$folder/$uid/$element').getDownloadURL();
      urlList.add(url);
    }
    return urlList;
  }
}