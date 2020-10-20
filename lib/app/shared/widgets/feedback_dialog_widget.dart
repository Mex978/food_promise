import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:google_fonts/google_fonts.dart';

void errorDialog(String title, String message) {
  Get.snackbar(
    title,
    message,
    forwardAnimationCurve: Curves.ease,
    reverseAnimationCurve: Curves.ease,
    backgroundColor: Colors.red[600],
    colorText: Colors.white,
    icon: Icon(Icons.error),
  );
}

void successDialog(String title, String message) {
  Get.snackbar(
    title,
    message,
    forwardAnimationCurve: Curves.ease,
    reverseAnimationCurve: Curves.ease,
    backgroundColor: Colors.green[600],
    colorText: Colors.white,
    icon: Icon(Icons.check_circle),
  );
}

void foodPromiseDialog(String title, String message, bool sucess) {
  final titleStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18));

  final messageStyle = GoogleFonts.openSans(
      textStyle: TextStyle(color: Colors.white, fontSize: 16));

  asuka.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        sucess
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : Icon(
                Icons.close,
                color: Colors.white,
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '$title',
                    style: titleStyle,
                  ),
                ),
                Text(
                  '$message',
                  style: messageStyle,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    backgroundColor: sucess ? Colors.green[600] : Colors.red[600],
  ));
}
