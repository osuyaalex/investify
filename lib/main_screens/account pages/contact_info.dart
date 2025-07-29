import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:investify/constant/appColors.dart';
import 'package:investify/tools/sizes.dart';

import '../../firebase/image_service.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  Map<String, dynamic> _data = {};
  TextEditingController _name = TextEditingController();
  TextEditingController _bday = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();


  late StreamSubscription<DocumentSnapshot> _userSubscription;
  void _listenToUser() {
    _userSubscription = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists && doc.data() != null) {
        setState(() {
          _data = doc.data() as Map<String, dynamic>;
          _name.text = _data['name'];
          _bday.text = _data['birthday']??'';
          _gender.text = _data['gender']??'';
          _email.text = _data['email']??'';
          _phoneNumber.text = _data['phoneNumber']??'';
          _address.text = _data['address']??'';
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenToUser();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _userSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        //backgroundColor: AppColors.scaffoldBackground,
        title: Text('Contact Info',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.pW),
        child: SingleChildScrollView(
          child: Column(
            children: [
              2.5.gap,
               CircleAvatar(
                radius: 16.pW,
                 backgroundImage: NetworkImage(
                   _data['image']??'https://www.iprcenter.gov/image-repository/blank-profile-picture.png/@@images/image.png'
                 ),
                 child: IconButton(
                     onPressed: ()async{
                       await ImageServices().pickImages(ImageSource.gallery);
                     },
                     icon: Icon(Icons.edit, color: Colors.white,)
                 ),
              ),
              2.5.gap,
              _fields('Name', _name),
              2.5.gap,
              _fields('Birthday', _bday),
              2.5.gap,
              _fields('Gender', _gender),
              2.5.gap,
              _fields('Email', _email),
              2.5.gap,
              _fields('Phone Number', _phoneNumber),
              2.5.gap,
              _fields('Address', _address),
              2.5.gap,
            ],
          ),
        ),
      ),
    );
  }
  Widget _fields(String label, TextEditingController controller ){
    return TextFormField(
      controller: controller,
        decoration: InputDecoration(
            labelText:label,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text('Change',
            style: TextStyle(
              color: AppColors.elevateGreen,
              fontSize: 13
            ),
            ),
          ),

        )
    );
  }
}
