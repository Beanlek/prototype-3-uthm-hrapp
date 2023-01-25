// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:prototype_3_uthm_hrapp/services/auth.dart';
// import 'dart:io';
import 'dart:async';

// import 'services/auth.dart';
// import 'model/student.dart';
import 'home_page_admin.dart';
import 'home_page_student.dart';
import 'error.dart';
import 'model/app_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _checkUser();
  }
  
  void _checkUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    String? userCheck;
    
    setState(() {
      getUserr();
    });

    var collection = FirebaseFirestore.instance.collection('AppUser');
    var docSnapshot = await collection.doc(user.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['role']; // <-- The value you want to retrieve. 
      // Call setState if needed.
      setState(() {
        userCheck = value;
      });
    }

    if(userUpValue?[0] == userCheck && userUpValue?[0] == 'Student'){
      navigateNext(HomePage());
    } else if(userUpValue?[0] == userCheck && userUpValue?[0] == 'Admin'){
      navigateNext(HPageAdmin());
    }else{
      navigateNext(Error(userCheck: userCheck));
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}