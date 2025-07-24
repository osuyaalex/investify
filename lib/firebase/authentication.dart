import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investify/main_screens/main_home.dart';
import 'package:investify/tools/utilities.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AuthService extends ChangeNotifier{
  bool isLoading = false;
  List<Map<String, dynamic>> generateLanSuggestions() {
    return [
      {
        "firstGradColor": 0xffD3D3D3,
        "secondGradColor": 0xffA9A9A9,
        "image": "result (1).png",
        "title": "Silver",
        "subTitle": "60% return",
        "activity": List.generate(5, (_) => generateRandomActivity())
      },
      {
        "firstGradColor": 0xffC0C0C0,
        "secondGradColor": 0xff808080,
        "image": "result (2).png",
        "title": "Platinum",
        "subTitle": "90% return",
        "activity": List.generate(5, (_) => generateRandomActivity())
      },

      {
        "firstGradColor": 0xffFFD700,
        "secondGradColor": 0xffFFA500,
        "image": "result.png",
        "title": "Gold",
        "subTitle": "30% return",
        "activity": List.generate(5, (_) => generateRandomActivity())
      },
    ];
  }

  Map<String, dynamic> generateRandomActivity() {
    final random = Random();

    int number = 100000 + random.nextInt(900000);
    String formattedNumber = number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    ).replaceAll(RegExp(r'\.(?=\d{3}\.)'), '');

    DateTime dateTime = DateTime.now().subtract(Duration(
      days: random.nextInt(30),
      hours: random.nextInt(24),
      minutes: random.nextInt(60),
    ));

    String code = List.generate(3, (_) => String.fromCharCode(65 + random.nextInt(26))).join();
    String actionType = random.nextBool() ? 'Buy' : 'Sell';
    String action = '$actionType "$code" stock';

    return {
      'number': formattedNumber,
      'dateTime': dateTime.toIso8601String(),
      'action': action,
    };
  }

  List<Map<String, dynamic>> generateInvestmentGuides() {
    return [
      {
        "title": "Getting Started with Stocks",
        "subTitle": "A beginner's roadmap to stock trading.",
        "image": "https://www.maxfosterphotography.com/images/xl/Radiant-Swirl.jpg"
      },
      {
        "title": "Understanding Risk Management",
        "subTitle": "How to protect your capital while investing.",
        "image": "https://www.robertlangestudios.com/cdn/shop/articles/abstract-art-definition.jpg?v=1708438116&width=900"
      },
      {
        "title": "Technical vs Fundamental Analysis",
        "subTitle": "Which one suits your investment style?",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1kcXJLfErP1HGAiIp65A_Z-1jpV-Pbg8SwA&s"
      },
      {
        "title": "Building a Diversified Portfolio",
        "subTitle": "Spreading risk across asset classes.",
        "image": "https://static.vecteezy.com/system/resources/previews/020/616/899/non_2x/eye-in-abstract-art-style-cube-style-for-poster-banner-or-background-illustration-vector.jpg"
      },
      {
        "title": "The Psychology of Investing",
        "subTitle": "Emotions, discipline, and long-term thinking.",
        "image": "https://depositphotos-blog.s3.eu-west-1.amazonaws.com/uploads/2023/06/7-Types-of-Abstract-Art-for-Inspiring-Designs_7.jpeg"
      },
    ];
  }



  Future<String?> signUpUsers(String firstName,String email, String password, BuildContext context)async{
    try{
      isLoading =true;
      notifyListeners();
      UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = cred.user!.uid;
      await firestore.collection('Users').doc(cred.user!.uid).set({
        "name": firstName,
        "birthday": null,
        "gender": null,
        "email": email,
        "image":null,
        'createdAt': FieldValue.serverTimestamp(),
        "phoneNumber":null,
        "totalAssetPortfolio": 200000
      });

      // Add Plan Suggestions
      List<Map<String, dynamic>> plans = generateLanSuggestions();
      for (var plan in plans) {
        await firestore.collection('Users').doc(uid).collection('PlanSuggestions').add(plan);
      }

      // Add Investment Guides
      List<Map<String, dynamic>> guides = generateInvestmentGuides();
      for (var guide in guides) {
        await firestore.collection('Users').doc(uid).collection('InvestmentGuide').add(guide);
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return MainHome();
      }));
      notifyListeners();
      return 'Account created successfully';
    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showAlert(context,'Error', "This email is already in use.", 'close');
        notifyListeners();
        return 'This email is already in use.';
      }else if(e.code == 'weak-password'){
        showAlert(context,'Error', "The given password is invalid. [ Password should be at least 6 characters ]", 'close');
        notifyListeners();
        return ' The given password is invalid. [ Password should be at least 6 characters ]';
      } else {
        showAlert(context,'Error', e.code, 'close');
        notifyListeners();
        return e.code;
      }
    } catch (e) {
    showAlert(context,'Error', e.toString(), 'close');
    notifyListeners();
      print(e);
      return 'An unknown error occurred.';
    }
  }

  Future<String?> signInUsersWithEmailAndPassword(String email, String password, BuildContext context)async{
    try{
      isLoading =true;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return MainHome();
      }));
      notifyListeners();
      return 'login Successful';
    }on FirebaseAuthException catch(e){
      if(e.code == 'invalid-credential'){
        showAlert(context,'Error', 'There are no valid credentials for this account. Please try signing up instead', 'close');
        return 'There are no valid credentials for this account. Please try signing up instead';
      }
      showAlert(context,'Error', e.code, 'close');
      return e.code;
    }catch(e){
      showAlert(context,'Error', e.toString(), 'close');
      return e.toString();
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  showAlert(BuildContext context,String title,String content,String defaultAction, {Function(bool)? onDismissed = null}) {
    Utilities.showAlertDialog(
        context: context,
        title: title,
        content: content,
        defaultActionText: defaultAction,
        onDismissed: (value) {
          if (onDismissed != null) onDismissed(value);
        });
  }
}