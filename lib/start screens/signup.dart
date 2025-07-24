import 'package:flutter/material.dart';
import 'package:investify/constant/appColors.dart';
import 'package:investify/firebase/authentication.dart';
import 'package:investify/main_screens/main_home.dart';
import 'package:investify/start%20screens/login.dart';
import 'package:investify/tools/sizes.dart';
import 'package:investify/tools/utilities.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../widgets/elevated_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _email;
  String? _fullName;
  String? _password;
  bool _isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.pW),
          child: Center(
            child: Column(
              children: [
                Text('Create an account',
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text('Invest and double your income now',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  ),
                ),
                4.gap,
                TextFormField(
                  onChanged: (value) {
                    _fullName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  //style: theme.textTheme.bodySmall,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 3,left: 10),
                      errorStyle: TextStyle(
                          fontSize: 14
                      ),
                      hintText: 'Full name',
                      hintStyle: TextStyle(
                          height: 2,
                          fontSize: 14
                      ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400
                      )
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400
                          )
                      )
                  ),
                ),
                1.gap,
                TextFormField(
                  onChanged: (value) {
                    _email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your email';
                    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.?[a-zA-Z]+)$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  //style: theme.textTheme.bodySmall,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 3,left: 10),
                      errorStyle: TextStyle(
                          fontSize: 14
                      ),
                      hintText: 'Email address',
                      hintStyle: TextStyle(
                          height: 2,
                          fontSize: 14
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400
                          )
                      )
                  ),
                ),
                1.gap,
                TextFormField(
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  //style: theme.textTheme.bodySmall,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 3,left: 10),
                      errorStyle: TextStyle(
                          fontSize: 14
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          height: 2,
                          fontSize: 14
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400
                          )
                      )
                  ),
                ),
                3.1.gap,
                ConstElevatedButton(
                    onPressed: (){
                      if(_key.currentState!.validate()){
                        Utilities.hideKeyboard(context);
                        Provider.of<AuthService>(context, listen: false).signUpUsers(_fullName!, _email!, _password!, context);
                      }
                    },
                    text: Consumer<AuthService>(
                      builder: (con, appServices, child) {
                        if (appServices.isLoading) {
                          _isLoading = true;
                          return SizedBox(
                              child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: const [Colors.white],
                                  strokeWidth: 2,
                                  backgroundColor: Colors.transparent,
                                  pathBackgroundColor: Colors.black));
                        }
                        // if (appServices.error.isNotEmpty) {
                        //   isLoading = false;
                        //   UiUtils.showSnackBar(context, '${appServices.error}');
                        //   return Text('Continue');
                        // }
                        _isLoading = false;
                        return Text('Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                        );
                      },
                    ),
                ),
                2.gap,
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }));
                    },
                    child: Text('Already have an account?',
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
      ),
    );
  }
}
