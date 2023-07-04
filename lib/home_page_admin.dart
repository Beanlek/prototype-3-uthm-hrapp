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
import 'model/house.dart';
import 'services/auth.dart';
import 'model/app_user.dart';
import 'create_landlord.dart';

class HPageAdmin extends StatefulWidget {
  const HPageAdmin({super.key});

  @override 
  State<HPageAdmin> createState() => _HPageAdminState();
}

class _HPageAdminState extends State<HPageAdmin>{
  final user = FirebaseAuth.instance.currentUser!;

  @override 
  Widget build(BuildContext context) {

    setState((){
      userValue = 'Admin';
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('HomePage | Admin'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Logged in as Admin'),
              Text(user.email!),
              Text(user.uid),

              StreamBuilder(
                stream: readUsername(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  }else if (snapshot.hasData) {
                    String student = snapshot.data;//.data();
            
                    return Text(student);
                  }else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp())
                  );
                },
                child: Text('LOG OUT')
              ),
              SizedBox(height: 50,),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewLandlord())
                  );
                },
                child: Text('ADD LANDLORD AND HOUSE')
              ),

              SizedBox(height: 50,),

              SizedBox(
                height: 500,
                child: StreamBuilder<List<House>>(
                  stream: readAllHouse(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    }else if (snapshot.hasData) {
                      final houses = snapshot.data!;
                    
                      return ListView(
                        children: houses.map(buildHouseStudentDelete).toList(),
                      );
                    }else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}