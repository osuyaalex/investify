import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investify/main_screens/account%20pages/contact_info.dart';
import 'package:investify/tools/sizes.dart';
import 'package:provider/provider.dart';

import '../constant/appColors.dart';
import '../tools/theme_provider.dart';

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


    return  Consumer<ThemeNotifier>(
      builder: (context,themeNotifier,child) {
        bool isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
        return Scaffold(
          //backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Row(
                children: [
                   Icon(Icons.light_mode,
                  color: isDarkMode?Colors.grey.shade400:
                     AppColors.elevateGreen,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isDarkMode,
                      activeColor: AppColors.elevateGreen,
                      onChanged: (value) {
                        themeNotifier.setTheme(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                  Icon(Icons.dark_mode,
                    color: isDarkMode?AppColors.elevateGreen:
                    Colors.grey.shade400,
                  ),
                  2.gap
                ],
              ),

            ],
            //backgroundColor: AppColors.scaffoldBackground,
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
                  button(SvgPicture.asset('assets/Shape.svg'), 'Contact Info',isDarkMode),
                  2.gap,
                  button(SvgPicture.asset('assets/funding.svg'), 'Source of Funding Info',isDarkMode),
                  2.gap,
                  button(SvgPicture.asset('assets/bank.svg'), 'Bank Account Info',isDarkMode),
                  2.gap,
                  button(SvgPicture.asset('assets/doc.svg'), 'Document Info',isDarkMode),
                  2.gap,
                  button(SvgPicture.asset('assets/setting.svg'), 'Settings',isDarkMode),
                  2.gap,
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  Widget button(SvgPicture icon, String text, bool isDark){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.pW),
      child: Container(
        width: double.infinity,
        height: 13.pW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDark?Colors.black:Colors.white,
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
