// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'main.dart';
import 'services/auth.dart';
import 'signup_page.dart';
import 'model/app_user.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  
  @override 
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage>{
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override 
  Widget build(BuildContext contxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In Page')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              textInputAction: TextInputAction.next,

              decoration: InputDecoration(
                labelText: 'Username'
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

            DropdownButton(
              value: userValue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: userCheck.map((String userCheck) {
                  return DropdownMenuItem(
                    value: userCheck,
                    child: Text(userCheck)
                  );
                }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  userValue = newValue!;
                });
              },
            ),

            ElevatedButton(
              onPressed: () {
                final String username = usernameController.text.trim();
                final String password = passwordController.text.trim();

                bool error = false;

                if (username.isEmpty){
                  error = true;
                }
                if (password.isEmpty){
                  error = true;
                }
                
                if (error == false) {//if xde error, terus jalan code ni
                  userUpValue!.clear();
                  userUpValue!.add(userValue);
                  saveUserr(userUpValue);

                  getEmail(username).then((QuerySnapshot snap) async{
                    context.read<AuthService>().logIn(
                      snap.docs[0]['email'],
                      password,
                    );
                  });
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp())
                  );
                }
              },
              child: Text('LOG IN')
            ),

            SizedBox(height: 20,),

            TextButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage())
                );
              },
              child: Text('Sign Up')
            )
            
          ],
        ),
      ),
    );
  }
}