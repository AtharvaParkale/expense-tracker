import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

  static Map<String, String> getTodayRange() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).toIso8601String();
    final endOfDay = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ).toIso8601String();

    return {'start': startOfDay, 'end': endOfDay};
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

  static String weekRange(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final formatter = DateFormat('MMM d');
    final year = DateFormat('y');

    return "${formatter.format(startOfWeek)} – ${formatter.format(endOfWeek)} ${year.format(date)}";
  }

  static Map<String, List<Expense>> groupExpensesByWeek(
    List<Expense> expenses,
  ) {
    expenses.sort(
      (a, b) =>
          DateTime.parse(a.createdAt).compareTo(DateTime.parse(b.createdAt)),
    );

    final Map<String, List<Expense>> grouped = {};

    for (final expense in expenses) {
      final dateTime = DateTime.parse(expense.createdAt);
      final week = weekRange(dateTime);

      grouped.putIfAbsent(week, () => []);
      grouped[week]!.add(expense);
    }

    return grouped;
  }

  static Map<String, double> aggregateMonthlySpends(List<Expense> expenses) {
    final Map<String, double> monthlySpends = {};

    for (final expense in expenses) {
      final dateTime = DateTime.parse(expense.createdAt);

      final monthKey = DateFormat('MMM yyyy').format(dateTime);

      monthlySpends[monthKey] = (monthlySpends[monthKey] ?? 0) + expense.amount;
    }

    return monthlySpends;
  }
}
