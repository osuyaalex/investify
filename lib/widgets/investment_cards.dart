import 'package:flutter/material.dart';
import 'package:investify/tools/sizes.dart';

class InvestmentCards extends StatelessWidget {
  final Color firstGradColor;
  final Color secondGradColor;
  final String image;
  final String title;
  final String subTitle;
  const InvestmentCards({super.key, required this.firstGradColor, required this.secondGradColor, required this.image, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.pW,
      height: 20.pH,
      //padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient:  LinearGradient(
          colors: [firstGradColor, secondGradColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: -20,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                Image.asset('assets/${image}',height: 28.pW,width: 28.pW,opacity: AlwaysStoppedAnimation(0.4),)
                ],
              ),
            ),
          ),
          // 📝 Text Content
          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
