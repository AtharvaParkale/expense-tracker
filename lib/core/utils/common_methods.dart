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

  static List<Expense> dummyExpenses = [
    Expense(
      id: "1",
      userId: "user1",
      category: "Food",
      title: "Groceries",
      amount: 500,
      createdAt: "2025-08-21",
    ),
    Expense(
      id: "2",
      userId: "user1",
      category: "Transport",
      title: "Uber Ride",
      amount: 300,
      createdAt: "2025-08-21",
    ),
    Expense(
      id: "3",
      userId: "user1",
      category: "Shopping",
      title: "T-shirt",
      amount: 700,
      createdAt: "2025-08-21",
    ),
    Expense(
      id: "3",
      userId: "user1",
      category: "Shopping",
      title: "T-shirt",
      amount: 700,
      createdAt: "2025-08-21",
    ),
    Expense(
      id: "3",
      userId: "user1",
      category: "Shopping",
      title: "T-shirt",
      amount: 700,
      createdAt: "2025-08-21",
    ),
  ];
}
