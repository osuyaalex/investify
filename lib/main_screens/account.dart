import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investify/main_screens/account%20pages/contact_info.dart';
import 'package:investify/tools/sizes.dart';

import '../constant/appColors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic> _data = {};
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
    return  Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.pW),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 29,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),
              2.gap,
              SizedBox(
                height: 15.pH,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 16.pW,
                        backgroundImage: NetworkImage(
                          _data['image']??'https://www.iprcenter.gov/image-repository/blank-profile-picture.png/@@images/image.png'
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2.pW,
                      right: 0,
                        child: SvgPicture.asset('assets/Rectangle 4.svg')
                    )
                  ],
                ),
              ),
              1.5.gap,
              Text(_data['name']??'Guest',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
              ),
              0.1.gap,
              Text('Expert',
              style: TextStyle(
                fontSize: 16
              ),
              ),
              2.gap,
              button(SvgPicture.asset('assets/Shape.svg'), 'Contact Info'),
              2.gap,
              button(SvgPicture.asset('assets/funding.svg'), 'Source of Funding Info'),
              2.gap,
              button(SvgPicture.asset('assets/bank.svg'), 'Bank Account Info'),
              2.gap,
              button(SvgPicture.asset('assets/doc.svg'), 'Document Info'),
              2.gap,
              button(SvgPicture.asset('assets/setting.svg'), 'Settings'),
              2.gap,
            ],
          ),
        ),
      ),
    );
  }
  Widget button(SvgPicture icon, String text,){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.pW),
      child: Container(
        width: double.infinity,
        height: 13.pW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 9),
            ),
          ],
        ),
        child: ListTile(
          leading:icon,
          title: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,size: 17,),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ContactInfo();
            }));
          },
        ),
      ),
    );
  }
}
