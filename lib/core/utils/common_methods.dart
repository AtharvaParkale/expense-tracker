import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonMethods {
  static Future<List<dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  EdgeInsetsGeometry getStandardPadding() {
    return const EdgeInsets.all(35);
  }

  int getAverage(int num1, int num2) {
    return ((num1 + num2) / 2).round();
  }

  int calculateWeeklyWeightGainInGrams(
    int dailyCalories,
    int maintenanceCalories,
  ) {
    final surplus = dailyCalories - maintenanceCalories;
    if (surplus <= 0) return 0;

    return ((surplus * 7 * 1000) / 7700).round();
  }

  String getFormattedDate() {
    final now = DateTime.now();
    final month = _getMonthName(now.month);
    return 'Today, $month ${now.day}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  double calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
}
