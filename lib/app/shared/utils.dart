import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:asuka/asuka.dart' as asuka;

class FoodPromiseUtils {
  static String enumToString(Object o) => o.toString().split('.').last;

  static T enumFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumToString(v), orElse: () => null);

  static String timestampToHuman(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final format = DateFormat('dd/MM/y');
    return format.format(date);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String getInitials(String str) {
    if (str == null || str.isEmpty) return null;

    var finalResult = '';
    final aux = str.trim().split(' ');
    final listStr = [aux.first];
    if (aux.first != aux.last) listStr.add(aux.last);

    for (var item in listStr) {
      finalResult += item[0];
    }
    return finalResult;
  }

  static void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black26,
    );
  }

  static void foodPromiseDialog(String title, String message, bool success) {
    final titleStyle = GoogleFonts.openSans(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18));

    final messageStyle = GoogleFonts.openSans(
        textStyle: TextStyle(color: Colors.white, fontSize: 16));

    final content = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        success
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
    );

    asuka.showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green[600] : Colors.red[600],
        content: content,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
