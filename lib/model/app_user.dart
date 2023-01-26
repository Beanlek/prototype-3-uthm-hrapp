// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables, unused_element

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter/material.dart';
// import 'dart:io';

List<String>? userUpValue = [];

saveUserr(list) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setStringList("key", list);

  return true;
}

getUserr() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getStringList("key") != null) {
    userUpValue = prefs.getStringList("key");
  }
  // setState(() {});
}

String userValue = 'Student';

  List<String> userCheck= [
    'Student',
    'Admin'
  ];

class AppUser {
  String appuserId;
  String email;
  String username;
  String phone;
  String role;
  // String password;

  AppUser({
    this.appuserId = '',
    required this.email,
    required this.username,
    required this.phone,
    required this.role,
    // required this.password
  });

  Map<String, dynamic> toJson() => {
    'appuserId' : appuserId,
    'email' : email,
    'username' : username,
    'phone' : phone,
    'role' : role,
    // 'password' : password
  };

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
    appuserId: json['appuserId'],
    email: json['email'],
    username: json['username'],
    phone: json['phone'],
    role: json['role'],
    // password: json['password']
  );
}