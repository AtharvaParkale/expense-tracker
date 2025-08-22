import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, List<Expense>>> getExpensesByDateRange(
    bool shouldFetchDailyExpenses,
  );

  Future<Either<Failure, List<Expense>>> addExpense({
    required String title,
    required String category,
    required double amount,
  });
}
