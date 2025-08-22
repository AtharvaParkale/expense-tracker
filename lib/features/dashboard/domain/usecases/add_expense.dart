import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddExpenseParams {
  final String title;
  final String category;
  final double amount;

  AddExpenseParams({
    required this.title,
    required this.category,
    required this.amount,
  });
}

class AddExpense implements UseCase<List<Expense>, AddExpenseParams> {
  final DashboardRepository dashboardRepository;

  AddExpense(this.dashboardRepository);

  @override
  Future<Either<Failure, List<Expense>>> call(AddExpenseParams params) async {
    return await dashboardRepository.addExpense(
      title: params.title,
      category: params.category,
      amount: params.amount,
    );
  }
}
