import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Keywords {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<String>> getKeywords(String type) async {
    List<String> list = [];
    final ref = db.collection('keywords');
    await ref.doc(type).get().then(
      (value) {
        List tmp = value.data()!['keys'];
        for (var i = 0; i < tmp.length; i++) {
          list.add(tmp[i]);
        }
      },
    );
    list.sort((a, b) => a.toString().compareTo(b.toString()));
    if (type == 'locations') {
      list.insert(0, 'not specified');
    }
    print('getKeywords');
    return list;
  }
}
