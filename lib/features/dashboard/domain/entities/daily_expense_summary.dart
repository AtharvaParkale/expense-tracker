import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';

class DailyExpenseSummary {
  final double total;
  final int totalCount;
  final double average;
  final double max;
  List<Expense> dailyExpenses = [];

  DailyExpenseSummary(
    this.dailyExpenses, {
    required this.total,
    required this.totalCount,
    required this.average,
    required this.max,
  });
}
