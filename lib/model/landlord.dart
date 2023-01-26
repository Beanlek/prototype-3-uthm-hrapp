// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';

// import 'package:flutter/material.dart';
// import 'dart:io';

// Future<QuerySnapshot> getHouseByLord(String lordId) async{
//   QuerySnapshot snap = await FirebaseFirestore.instance
//     .collection('Landlord')
//     .where("lordlordId", isEqualTo: 'Landlord/$lordlordId').get();

//   return snap;
// }

Future<String> createLandlord(String lordName, String phone, String link, String houseId) async{
  final docLord = FirebaseFirestore.instance.collection('Landlord').doc();

  final lord = Landlord(
    lordId: docLord.id,
    lordName: lordName,
    houseId: [houseId],
    phone : phone,
    link: link
  );
  final json = lord.toJson();

  await docLord.set(json);

  return docLord.id;
}

Stream readLordName(String uid) => FirebaseFirestore.instance
  .collection('Landlord')
  .doc(uid)//"6QOnUo8PQhdqtKQtzKXhSOOC4K43")
  .snapshots()
  .map((snapshot) => 
    snapshot.data().toString().contains("lordName") ? snapshot.get("lordName") : 'nothing',
  );

class Landlord {
  String lordId;
  String lordName;
  List<String> houseId;
  String phone;
  String link;

  Landlord({
    this.lordId = '',
    required this.lordName,
    required this.houseId,
    required this.phone,
    required this.link
  });

  Map<String, dynamic> toJson() => {
    'lordlordId': lordId,
    'lordName': lordName,
    'houseId' : houseId,
    'phone' : phone,
    'link': link
  };

  static Landlord fromJson(Map<String, dynamic> json) => Landlord(
    lordId: json['lordlordId'],
    lordName: json['lordName'],
    houseId: json['houseId'],
    phone: json['phone'],
    link: json['link']
  );
}