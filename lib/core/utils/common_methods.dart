import 'dart:convert';

import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonMethods {
  static double getTotal(List<Expense> expenses) {
    return expenses.fold(0, (sum, e) => sum + e.amount);
  }

  static int getCount(List<Expense> expenses) {
    return expenses.length;
  }

  static double getAverage(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    return getTotal(expenses) / getCount(expenses);
  }

  static double getMaxExpenseAmount(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    return expenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
  }
}
