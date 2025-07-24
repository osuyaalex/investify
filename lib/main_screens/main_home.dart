import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investify/constant/appColors.dart';
import 'package:investify/main_screens/account.dart';
import 'package:investify/main_screens/home.dart';
import 'package:investify/main_screens/product.dart';
import 'package:investify/main_screens/transaction.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key,});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _currentIndex = 0;
  final List<Widget> _body = [
   HomePage(),
    ProductPage(),
    TransactionsPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _body[_currentIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: AppColors.scaffoldBackground,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: _currentIndex,
          selectedItemColor: Color(0xff005E5E),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          onTap: (newIndex){
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: SvgPicture.asset('assets/Home 1.svg'),
              activeIcon: SvgPicture.asset('assets/Home 1.svg',colorFilter: ColorFilter.mode(
                AppColors.elevateGreen,
                BlendMode.srcIn,
              ),)

            ),
            BottomNavigationBarItem(
              label: "Product",
              icon: SvgPicture.asset('assets/Search 1.svg'),
              activeIcon: SvgPicture.asset('assets/Search 1.svg',colorFilter: ColorFilter.mode(
                AppColors.elevateGreen,
                BlendMode.srcIn,
              ),)
            ),
            BottomNavigationBarItem(
              label: "Transaction",
              icon: SvgPicture.asset('assets/transaction 1.svg'),
              activeIcon: SvgPicture.asset('assets/transaction 1.svg',colorFilter: ColorFilter.mode(
                AppColors.elevateGreen,
                BlendMode.srcIn,
              ))
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: SvgPicture.asset('assets/Profile 1.svg'),
              activeIcon: SvgPicture.asset('assets/Profile 1.svg',colorFilter: ColorFilter.mode(
                AppColors.elevateGreen,
                BlendMode.srcIn,
              )),
            ),
          ]
      ),
    );
  }
}
