// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'theme/style.dart';
// import 'dart:io';

import 'services/auth.dart';
import 'splash_screen.dart';
import 'home_page_student.dart';
import 'login_page.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
        builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'prototype_3_uthm_hrapp',
          theme: mainTheme,//ThemeData(primarySwatch: Colors.blue),
          home: AuthWrapper(),
        );
      }
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SplashScreen();
              // return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              //   future: adminCheck(),//getUserValue(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return SplashScreen(userValue: 'Admin',);
              //     }else {
              //       return SplashScreen(userValue: 'Students',);
              //     }
              //   }
              // );
            }else {
              return LogInPage();
            }
          },
        ),
      );
  }
}
