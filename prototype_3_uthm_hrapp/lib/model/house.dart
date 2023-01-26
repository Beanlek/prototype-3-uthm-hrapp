// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'landlord.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'dart:io';

Widget buildHouseStudent(House house) => ListTile(
  leading: SizedBox(
    width: 100,
    child: Image.network(house.imageUrl, fit: BoxFit.fitWidth,)
  ),
  title: Text(house.houseName),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RM ${house.rentPrice.toString()}', textAlign: TextAlign.start,),
      Row(
        children: [
          SizedBox(
            width: 150,
            child: AutoSizeText(house.houseAddress,
              maxLines: 2,
            ),
          ),
          StreamBuilder(
            stream: readLordName(house.lordId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              }else if (snapshot.hasData) {
                String landlord = snapshot.data;//.data();
        
                return SizedBox(
                  width: 80,
                  child: AutoSizeText(landlord, maxLines: 2, textAlign: TextAlign.right,)
                );
              }else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
          ),
        ],
      ),
    ],
  ),
);

Stream<List<House>> readAllHouse() => FirebaseFirestore.instance
  .collection('House')
  .snapshots()
  .map((snapshot) => 
    snapshot.docs.map((doc) => House.fromJson(doc.data())).toList()
  );

Future createHouse(String houseName, String houseAddress, double rentPrice, String imageUrl, String lordId, String houseId) async{
  final docHouse = FirebaseFirestore.instance
    .collection('House')
    .doc(houseId);

  final house = House(
    lordId: lordId,
    houseId: houseId,
    houseName: houseName,
    houseAddress: houseAddress,
    rentPrice: rentPrice,
    imageUrl: imageUrl
  );
  final json = house.toJson();

  await docHouse.set(json);
}

class House {
  String lordId;

  String houseId;
  String houseName;
  String houseAddress;
  double rentPrice;
  String imageUrl;

  House({
    required this.lordId,
    this.houseId = '',
    required this.houseName,
    required this.houseAddress,
    required this.rentPrice,
    required this.imageUrl
  });

  Map<String, dynamic> toJson() => {
    'lordId' : lordId,
    'houseId': houseId, 
    'houseName': houseName,
    'houseAddress' : houseAddress,
    'rentPrice' : rentPrice,
    'imageUrl': imageUrl
  };

  static House fromJson(Map<String, dynamic> json) => House(
    lordId: json['lordId'],
    houseId: json['houseId'],
    houseName: json['houseName'],
    houseAddress: json['houseAddress'],
    rentPrice: json['rentPrice'],
    imageUrl: json['imageUrl']
  );
}