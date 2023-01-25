// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'dart:io';

// import 'main.dart';
// import 'services/auth.dart';
// import 'model/app_user.dart';
import 'model/house.dart';
import 'home_page_admin.dart';
import 'model/landlord.dart';

class NewHouse extends StatefulWidget {

  const NewHouse({
    super.key,
    required this.lordName,
    required this.lordPhone,
    required this.lordLink,
  });

  final String lordName;
  final String lordPhone;
  final String lordLink;
  
  @override 
  State<NewHouse> createState() => _NewHouseState();
}

class _NewHouseState extends State<NewHouse>{
  final houseNameCont = TextEditingController();
  final houseAddressCont = TextEditingController();
  final rentPriceCont = TextEditingController();

  PlatformFile? pickedFile;

  Future confirmAdd(String hName, String hAddress, double rPrice) async{
    final docHouse = FirebaseFirestore.instance.collection('House').doc();
    final path = ('houseImage/${pickedFile!.name}');
    final file = File(pickedFile!.path!);
    String imagePath;

    Reference ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    Future<String> getUrlImage() async{
      final snapshot = await uploadTask.whenComplete(() => null);
      final urlImage = snapshot.ref.getDownloadURL();
      return urlImage;
    }

    getUrlImage().then((String url) async{
      imagePath = url;

      createLandlord(
        widget.lordName,
        widget.lordPhone,
        widget.lordLink,
        docHouse.id
      ).then((String lordId) async{
          createHouse(
            hName,
            hAddress,
            rPrice,
            imagePath,
            lordId,
            docHouse.id
          );
          // final house = House(
          //   lordId: lordId,
          //   houseId: docHouse.id,
          //   houseName: hName,
          //   houseAddress: hAddress,
          //   rentPrice: rPrice,
          //   imageUrl: imagePath
          // );
          // final json = house.toJson();

          // await docHouse.set(json);
        }
      );

      
    });

  }

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();

    setState(() {
      pickedFile = result?.files.first;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New House'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Column(
              children: [
                
                SizedBox(
                  height: 200,
                  child: pickedFile != null ? Image.file(
                    File(pickedFile!.path!)
                  ) : Text('Select an image')
                ),
                
                ElevatedButton(
                  child: Text('Select File'),
                  onPressed: () {
                    // getImage();
                    selectFile();
                  }
                ),
          
                TextField(
                  controller: houseNameCont,
                  textInputAction: TextInputAction.next,
          
                  decoration: InputDecoration(
                    labelText: 'House Name'
                  ),
                ),
          
                TextField(
                  controller: houseAddressCont,
                  textInputAction: TextInputAction.next,
          
                  decoration: InputDecoration(
                    labelText: 'House Address'
                  ),
                ),
          
                TextField(
                  controller: rentPriceCont,
                  textInputAction: TextInputAction.next,
          
                  decoration: InputDecoration(
                    labelText: 'Rent Price'
                  ),
                ),
          
                ElevatedButton(
                  child: Text('Upload File'),
                  onPressed: () {
                    String houseName = houseNameCont.text.trim();
                    String houseAddress = houseAddressCont.text.trim();
                    double rentPrice = double.parse(rentPriceCont.text);
          
                    confirmAdd(houseName, houseAddress, rentPrice);
          
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                        HPageAdmin()
                      )
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}