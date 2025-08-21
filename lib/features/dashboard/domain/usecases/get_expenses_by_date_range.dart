import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart' show Either;

class GetExpensesByDateRange implements UseCase<List<Expense>, NoParams> {
  final DashboardRepository dashboardRepository;

  GetExpensesByDateRange(this.dashboardRepository);

  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    return await dashboardRepository.getExpensesByDateRange();
  }
}
