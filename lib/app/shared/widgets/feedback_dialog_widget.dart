import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:google_fonts/google_fonts.dart';

errorDialog(String title, String message) {
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

successDialog(String title, String message) {
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
  final titleStyle = GoogleFonts.openSansCondensed(
    height: 18,
  );
  final messageStyle = GoogleFonts.openSans(
    height: 16,
  );

  asuka.showSnackBar(SnackBar(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(title, style: titleStyle),
        ),
        Text(message, style: messageStyle),
      ],
    ),
    backgroundColor: sucess ? Colors.green[600] : Colors.red[600],
  ));
}
