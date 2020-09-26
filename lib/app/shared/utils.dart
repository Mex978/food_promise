import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FoodPromiseUtils {
  static String enumToString(Object o) => o.toString().split('.').last;

  static T enumFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumToString(v), orElse: () => null);

  static String timestampToHuman(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final format = new DateFormat("dd/MM/y");
    return format.format(date);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
