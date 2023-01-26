// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
// import 'dart:io';

// import 'main.dart';
// import 'services/auth.dart';
// import 'model/app_user.dart';
import 'create_new_house.dart';

class NewLandlord extends StatefulWidget {
  const NewLandlord({super.key});

  @override 
  State<NewLandlord> createState() => _NewLandlordState();
}

class _NewLandlordState extends State<NewLandlord>{

  final lordNameController = TextEditingController();
  final lordPhoneController = TextEditingController();
  final lordLinkController = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Landlord'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: lordNameController,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  labelText: 'Landlord Name'
                )
              ),

              TextField(
                controller: lordPhoneController,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  labelText: 'Landlord Phone No.'
                )
              ),
              
              TextField(
                controller: lordLinkController,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  labelText: 'Landlord Contact Link'
                )
              ),
              
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String lordName = lordNameController.text.trim();
                      String lordPhone = lordPhoneController.text.trim();
                      String lordLink = lordLinkController.text.trim();

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => 
                          NewHouse(
                            lordName: lordName,
                            lordLink: lordLink,
                            lordPhone: lordPhone,
                          ))
                      );
                    }, 
                    child: Text('NEXT')
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('BACK')
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}