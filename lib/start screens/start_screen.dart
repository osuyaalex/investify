import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investify/constant/appColors.dart';
import 'package:investify/start%20screens/login.dart';
import 'package:investify/widgets/elevated_button.dart';
import 'package:investify/start%20screens/signup.dart';
import 'package:investify/tools/sizes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            children: [
              15.gap,
              Image.asset('assets/Asset 1 1.png',width: 70.pW,),
              2.gap,
              SizedBox(
                width: 70.pW,
                child: Text('Stay on top of your finance with us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800
                ),
                ),
              ),
              1.gap,
              SizedBox(
                width: 70.pW,
                  child: Text('We are your new financial Advisors to recommend the best investments for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    ),
                  )
              ),
              7.gap,
             ConstElevatedButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return SignUp();
                   }));
                 },
                 text: Text('Create Account',
                 style: TextStyle(
                   fontWeight: FontWeight.w500
                 ),
                 )
             ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginScreen();
                    }));
                  },
                  child: Text('Login',
                  style: TextStyle(
                    color: AppColors.elevateGreen,
                    fontSize: 15
                  ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
