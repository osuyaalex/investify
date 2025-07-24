import 'package:flutter/material.dart';
import 'package:investify/tools/sizes.dart';

import '../constant/appColors.dart';

class ConstElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget text;
  const ConstElevatedButton({super.key, required this.onPressed, required this.text});

  @override
  State<ConstElevatedButton> createState() => _ConstElevatedButtonState();
}

class _ConstElevatedButtonState extends State<ConstElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 70.pW,
      height: 12.pW,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(AppColors.elevateGreen),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: widget.text
      ),
    );
  }
}
