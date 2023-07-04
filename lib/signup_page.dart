// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'services/auth.dart';
import 'login_page.dart';
import 'model/app_user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  
  @override 
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,

              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),

            TextField(
              controller: usernameController,
              textInputAction: TextInputAction.next,

              decoration: InputDecoration(
                labelText: 'Username'
              ),
            ),
            
            TextField(
              controller: phoneController,
              textInputAction: TextInputAction.next,

              decoration: InputDecoration(
                labelText: 'Phone No.'
              ),
            ),
            
            TextField(
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              
              decoration: InputDecoration(
                labelText: 'Password'
              ),
            ),
            
            TextField(
              controller: confPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              
              decoration: InputDecoration(
                labelText: 'Confirm Password'
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final String email = emailController.text.trim();
                final String username = usernameController.text.trim();
                final String phone = phoneController.text.trim();
                final String password = passwordController.text.trim();
                final String confpassword = confPasswordController.text.trim();

                bool error = false;
                bool noPass = true;
                bool noConPass = true;

                if (email.isEmpty){
                  error = true;
                }
                if (username.isEmpty){
                  error = true;
                }
                if (password.isEmpty){
                  error = true;
                }else{noPass = false;}

                if (confpassword.isEmpty){
                  error = true;
                }else{noConPass = false;}

                if ((confpassword != password) && (noPass == false && noConPass == false)){
                  error = true;
                }
                
                if (error == false) {//if xde error, terus jalan code ni
                  context.read<AuthService>().signUp(
                    email,
                    username,
                    phone,
                    password
                  ).then((value) async {
                    User? user = FirebaseAuth.instance.currentUser;

                    final docStudent = FirebaseFirestore.instance.collection('AppUser').doc(user!.uid);//.doc(user!.uid);

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

                    // await FirebaseFirestore.instance.collection('Students').doc(user?.uid).set({
                    //   'userid' : user?.uid,
                    //   'email' : email,
                    //   'username' : username,
                    //   'phone' : phone,
                    //   'password' : password,
                    // });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('SIGN UP')
            ),

            SizedBox(height: 20,),
            
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Log In')
            )
          ],
        ),
      ),

    );
  }
}