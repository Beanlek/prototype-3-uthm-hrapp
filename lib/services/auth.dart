// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

// import 'package:firebase_core/firebase_core.dart';
// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';

// import 'package:flutter/material.dart';
// import 'dart:io';
import 'dart:async';

import '../model/app_user.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<User?> logIn(String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUp(String email, String username, String phone, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
        // String uid = user!.uid;
        // print(uid);
        final docStudent = FirebaseFirestore.instance.collection('AppUser').doc(user!.uid);//.doc(user!.uid);

        // await FirebaseFirestore.instance.collection("Baharu").doc().set({
        //   'userid' : ,
        //   'email' : email,
        //   'username' : username,
        //   'phone' : phone,
        //   'password' : password,
        // });

        final student = AppUser(
          appuserId: docStudent.id,
          email: email,
          username: username,
          phone: phone,
          role: 'Student',
          // password: password,
        );
        final json = student.toJson();

        await docStudent.set(json);
      });
      return user;
    } catch (e) {
      return null;
    }
  }
}

Future<QuerySnapshot> getEmail(String username) async{
  QuerySnapshot snap = await FirebaseFirestore.instance
    .collection('AppUser')
    .where("username", isEqualTo: username).get();

  return snap;
}

Stream readUsername(String uid) => FirebaseFirestore.instance
  .collection('AppUser')
  .doc(uid)//"6QOnUo8PQhdqtKQtzKXhSOOC4K43")
  .snapshots()
  .map((snapshot) => 
    snapshot.data().toString().contains("username") ? snapshot.get("username") : 'nothing',
  );

// Stream readAdmin(String uid) => FirebaseFirestore.instance
//   .collection('AppUser')
//   .doc(uid)
//   .snapshots()
//   .map((snapshot) => 
//     snapshot.data().toString().contains("role") ? snapshot.get("role") : 'nothing',
//   );

// Future<DocumentSnapshot<Map<String, dynamic>>> adminCheck() async => FirebaseFirestore.instance
//   .collection('Admin')
//   .doc('admin_exists_check')
//   .get();