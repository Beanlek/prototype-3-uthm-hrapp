// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:prototype_3_uthm_hrapp/model/app_user.dart';

import 'main.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.userCheck});

  final userCheck;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Error Log In Credentials'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(userCheck),
            Text(userValue),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp())
                );
              },
              child: Text('GO BACK TO MAIN')
            ),
          ],
        )
      ),
    );
  }
}