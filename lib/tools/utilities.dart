import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utilities{
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
    required Function(bool) onDismissed,
  }) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              CupertinoDialogAction(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            CupertinoDialogAction(
              child: Text(defaultActionText),
              onPressed: () {
                Navigator.of(context).pop(true);
                onDismissed(true);
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.w600
          ),
          content: Text(content),
          contentTextStyle: TextStyle(
              color: Colors.black54,
              fontSize: 17
          ),
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            TextButton(
              child: Text(defaultActionText),
              onPressed: () {
                Navigator.of(context).pop(true);
                onDismissed(true);
              },
            ),
          ],
        ),
      );
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}