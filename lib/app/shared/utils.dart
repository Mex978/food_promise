import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
}
