import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseAuth get auth {
    return _auth;
  }

  FirebaseFirestore get db {
    return _db;
  }

  //sign in with email & password
  Future login(String emailAddress, String password) async {
    try {
      final result = await _db.collection('companies').where('email',isEqualTo: emailAddress).get().then((value) => value);
      if (result.docs.isEmpty) {
        throw Exception('User is not a company!');
      }
      await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //register
  Future signup(
      String emailAddress, String password, String phone, String name) async {
    try {
      final credential =
          await _auth.createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      
      _db.collection('companies').doc(credential.user!.uid).set({
        'name' : name,
        'email' : emailAddress,
        'phone' : phone
    });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //log out
  Future<void> logout() async {
    await _auth.signOut();
  }
}
