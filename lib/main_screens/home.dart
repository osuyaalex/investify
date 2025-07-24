import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:investify/constant/appColors.dart';
import 'package:investify/tools/sizes.dart';
import 'package:investify/widgets/big_investment_card.dart';
import 'package:investify/widgets/investment_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> _fetchUserData(String userId) async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    final guideSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('InvestmentGuide')
        .get();
    final plans = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('PlanSuggestions')
        .get();

    return {
      'userData': userDoc.data(),
      'investmentGuide': guideSnapshot.docs.map((doc) => doc.data()).toList(),
      "plans": plans.docs.map((doc) => doc.data()).toList(),
    };
  }

  final List<Map<String,dynamic>> _imageDetails =[
    {
      "firstGradColor": 0xffFFD700,
     "secondGradColor": 0xffFFA500,
      "image": "result.png",
      "title": "Gold",
      "subTitle":"30% return"
    },
    {
      "firstGradColor": 0xffD3D3D3,
      "secondGradColor": 0xffA9A9A9,
      "image": "result (1).png",
      "title": "Silver",
      "subTitle":"60% return"
    },
    {
      "firstGradColor": 0xffC0C0C0,
      "secondGradColor": 0xff808080,
      "image": "result (2).png",
      "title": "Platinum",
      "subTitle":"90% return"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserData(auth.currentUser!.uid),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Something went wrong")));
        }
        if (snapshot.hasData && snapshot.data == null) {
          return Scaffold(body: Center(child: Text("Document does not exist")));
        }
        if(snapshot.connectionState == ConnectionState.done){
          //Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          final data = snapshot.data!['userData'];
          final guideList = snapshot.data!['investmentGuide'];
          final plans =snapshot.data!['plans'];
          String? fullName = data['name'].split(" ").first;
          String? totalAssets = NumberFormat('#,###').format(data['totalAssetPortfolio']);
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.scaffoldBackground,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  1.gap,
                  SvgPicture.asset('assets/menu.svg',),
                ],
              ),
              actions: [
                SvgPicture.asset('assets/Notification 1.svg'),
                2.gap
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.pW),
                    child: Text('Welcome, ${fullName??"Guest"}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 29,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  3.gap,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.pW),
                    child: Container(
                      padding: EdgeInsets.only(top:7.pW,left: 7.pW,bottom: 7.pW,right: 14),
                      width: double.infinity,
                      height: 15.pH,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: AppColors.elevateGreen,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.elevateGreen.withOpacity(0.22),
                            blurRadius: 35,
                            offset: Offset(0, 25),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your total asset portfolio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('N$totalAssets',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27
                                ),
                                ),
                                ElevatedButton(
                                    onPressed: (){
                                      bottomModal(totalAssets,plans, 0);
                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      )
                                    ),
                                    child: Text('Invest now',
                                    style: TextStyle(
                                      color: AppColors.elevateGreen
                                    ),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  3.5.gap,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.pW),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Best Plans',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20
                          ),
                        ),
                        Row(
                          children: [
                            Text('See All',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),),
                            Icon(Icons.arrow_forward,color: Colors.red,)
                          ],
                        )
                      ],
                    ),
                  ),
                  2.gap,
                  SizedBox(
                    height: 20.pH ,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: plans.length,
                        itemBuilder: (context, index){
                          final plan = plans[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: (){
                                bottomModal(totalAssets, plans, index);
                              },
                              child: InvestmentCards(
                                  firstGradColor: Color(plan['firstGradColor']),
                                  secondGradColor: Color(plan['secondGradColor']),
                                  image: plan['image'],
                                  title: plan['title'],
                                  subTitle: plan['subTitle']
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  3.gap,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.pW),
                    child: Text('Investment Guide',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20
                      ),
                    ),
                  ),
                  2.gap,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.pW),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: guideList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 65.pW,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(guideList[index]['title'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16
                                                  ),
                                                ),
                                                Text(guideList[index]['subTitle'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.black,
                                            backgroundImage: NetworkImage(guideList[index]['image']),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.grey.shade300,),
                                    1.gap,
                                  ],
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Center(
            child: CircularProgressIndicator(color: AppColors.elevateGreen,),
          ),
        );
      }
    );
  }

  bottomModal(String totalAssets, List plans, int topIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // So shadow isn't clipped
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              height: 90.pH,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, -4), // shadow at the top
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 12.0,right: 6.pW,left: 6.pW),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      1.gap,
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'My Asset',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.cancel,color: Colors.grey,),
                            )
                          ),
                        ],
                      ),
                      1.5.gap,
                      Text('Your total asset portfolio',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('N$totalAssets',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27
                              ),
                            ),
                            3.gap,
                            SvgPicture.asset('assets/Value increase.svg'),
                          ],
                        ),
                      ),
                      3.gap,
                      Text('Current Plans',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      1.gap,
                      BigInvestmentCards(
                          firstGradColor: Color(plans[topIndex]['firstGradColor']),
                          secondGradColor: Color(plans[topIndex]['secondGradColor']),
                          image: plans[topIndex]['image'],
                          title: plans[topIndex]['title'],
                          subTitle: plans[topIndex]['subTitle']
                      ),
                      1.7.gap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('See All Plans',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),),
                          0.5.gap,
                          Icon(Icons.arrow_forward,color: Colors.red,size: 16,)
                        ],
                      ),
                      2.gap,
                      Text('History',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      2.gap,
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: plans[topIndex]['activity'].length,
                                itemBuilder: (context, index){
                                  final activities = plans[topIndex]['activity'][index];
                                  DateTime date = DateTime.parse(activities['dateTime']);
                                  String formatDate = DateFormat('EEE dd MMM yyyy').format(date);
                                  Color rpColor = activities['action'].contains('Sell')?
                                      AppColors.elevateGreen:Colors.black;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rp ${activities['number']} ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: rpColor
                                      ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(activities['action'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13
                                          ),
                                          ),
                                          Text(formatDate,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Divider(color: Colors.grey.shade300,),
                                      )
                                    ],
                                  );
                                }
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            );
          },
        );
      },
    );
  }

}
