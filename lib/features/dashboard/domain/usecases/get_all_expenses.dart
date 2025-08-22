import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart' show Either;

class GetAllExpenses implements UseCase<List<Expense>, bool> {
  final DashboardRepository dashboardRepository;

  GetAllExpenses(this.dashboardRepository);

  @override
  Future<Either<Failure, List<Expense>>> call(
    bool shouldFetchDailyExpenses,
  ) async {
    return await dashboardRepository.getExpensesByDateRange(
      shouldFetchDailyExpenses,
    );
  }
}
